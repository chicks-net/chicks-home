# test and validation justfile

# run the test suite: perl tests in t/ plus the Go tests in bin/
# (best effort: Go tests are skipped when go is not installed)
[group('Testing/Automation')]
test:
    #!/usr/bin/env bash
    set -euo pipefail # strict mode

    prove t/

    if command -v go &> /dev/null; then
        go test bin/hello.go bin/hello_test.go
    else
        echo "{{BLUE}}go not found, skipping Go tests.  No judgment.{{NORMAL}}"
    fi

# generate coverage reports locally, mirroring .github/workflows/codecov.yml
# (Devel::Cover is not core perl; install with
#   cpanm --local-lib ~/perl5 Devel::Cover Devel::Cover::Report::Cobertura)
[group('Testing/Automation')]
coverage:
    #!/usr/bin/env bash
    set -euo pipefail # strict mode

    echo "{{MAGENTA}}Collecting Go coverage...{{NORMAL}}"
    go test -coverprofile=go-coverage.out bin/hello.go bin/hello_test.go

    echo "{{MAGENTA}}Collecting Perl coverage...{{NORMAL}}"
    if ! command -v cover &> /dev/null; then
        echo "{{BLUE}}cover not found, skipping Perl coverage.{{NORMAL}}"
        echo "{{BLUE}}Install with: cpanm --local-lib ~/perl5 Devel::Cover Devel::Cover::Report::Cobertura{{NORMAL}}"
        exit 0
    fi
    rm -rf cover_db
    PERL5OPT='-MDevel::Cover=-ignore,/usr/,-ignore,^t/' prove t/
    cover -silent -report cobertura

    echo "{{GREEN}}Coverage written to go-coverage.out and cover_db/cobertura.xml{{NORMAL}}"
