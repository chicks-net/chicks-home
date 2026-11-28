package main

import (
	"io"
	"os"
	"strings"
	"testing"
)

func TestHelloMain(t *testing.T) {
	// capture os.Stdout so calling main() can be observed
	old := os.Stdout
	r, w, err := os.Pipe()
	if err != nil {
		t.Fatal(err)
	}
	os.Stdout = w
	main()
	w.Close()
	os.Stdout = old

	out, _ := io.ReadAll(r)
	if strings.TrimSpace(string(out)) != "hello world" {
		t.Errorf("main() = %q, want %q", out, "hello world")
	}
}
