//go:build ignore

package main

import (
	"fmt"
	"io"
	"os"
	"path/filepath"
	"time"
)

func main() {
	homeDir, err := os.UserHomeDir()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error getting home directory: %v\n", err)
		os.Exit(1)
	}

	destDir := filepath.Join(homeDir, "Pictures", "ScreenShots")
	if err := os.MkdirAll(destDir, 0755); err != nil {
		fmt.Fprintf(os.Stderr, "Error creating destination directory: %v\n", err)
		os.Exit(1)
	}

	desktopPath := filepath.Join(homeDir, "Desktop")
	cutoffTime := time.Now().AddDate(0, 0, -30)

	patterns := []string{
		"Screenshot*.png",
		"Screen Shot*.png",
		"Screenshot*.jpg",
	}

	movedCount := 0
	failedCount := 0

	for _, pattern := range patterns {
		fullPattern := filepath.Join(desktopPath, pattern)
		matches, err := filepath.Glob(fullPattern)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error matching pattern %s: %v\n", pattern, err)
			continue
		}

		for _, file := range matches {
			info, err := os.Stat(file)
			if err != nil {
				fmt.Fprintf(os.Stderr, "Error reading file info %s: %v\n", filepath.Base(file), err)
				failedCount++
				continue
			}

			if info.ModTime().Before(cutoffTime) {
				filename := filepath.Base(file)
				destPath := filepath.Join(destDir, filename)

				if err := moveFile(file, destPath); err != nil {
					fmt.Fprintf(os.Stderr, "Failed to move: %s (%v)\n", filename, err)
					failedCount++
				} else {
					fmt.Printf("Moved: %s\n", filename)
					movedCount++
				}
			}
		}
	}

	remainingCount := 0
	for _, pattern := range patterns {
		fullPattern := filepath.Join(desktopPath, pattern)
		matches, err := filepath.Glob(fullPattern)
		if err != nil {
			continue
		}
		remainingCount += len(matches)
	}

	fmt.Printf("Script completed. %d file(s) moved, %d failed. %d screenshot(s) remain on desktop.\n",
		movedCount, failedCount, remainingCount)
}

func moveFile(src, dst string) error {
	if _, err := os.Stat(dst); err == nil {
		return fmt.Errorf("destination file already exists: %s", dst)
	}

	srcFile, err := os.Open(src)
	if err != nil {
		return err
	}
	defer srcFile.Close()

	dstFile, err := os.Create(dst)
	if err != nil {
		return err
	}
	defer dstFile.Close()

	if _, err := io.Copy(dstFile, srcFile); err != nil {
		os.Remove(dst)
		return err
	}

	srcInfo, err := os.Stat(src)
	if err == nil {
		os.Chmod(dst, srcInfo.Mode())
	}

	return os.Remove(src)
}
