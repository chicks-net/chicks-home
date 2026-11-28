package main

import (
	"io"
	"os"
	"strings"
	"testing"
)

// captureStdout runs f with os.Stdout redirected to a pipe and returns
// what f wrote.  Written as the template for future bin/ tests: stdout
// is restored even if f panics, and the reader goroutine prevents the
// pipe (~64KB buffer) from deadlocking on larger output.
func captureStdout(t *testing.T, f func()) string {
	t.Helper()

	old := os.Stdout
	r, w, err := os.Pipe()
	if err != nil {
		t.Fatal(err)
	}
	os.Stdout = w
	defer func() { os.Stdout = old }()

	out := make(chan string, 1)
	go func() {
		data, _ := io.ReadAll(r)
		r.Close()
		out <- string(data)
	}()

	f()
	w.Close()
	return <-out
}

func TestHelloMain(t *testing.T) {
	out := captureStdout(t, main)
	if strings.TrimSpace(out) != "hello world" {
		t.Errorf("main() = %q, want %q", out, "hello world")
	}
}
