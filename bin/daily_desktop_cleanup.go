//go:build ignore

package main

import (
	"fmt"
	"io"
	"os"
	"path/filepath"
	"time"
)

func logWithTimestamp(format string, args ...interface{}) {
	timestamp := time.Now().Format("2006-01-02 15:04:05")
	fmt.Printf("[%s] ", timestamp)
	fmt.Printf(format, args...)
}

func logError(format string, args ...interface{}) {
	timestamp := time.Now().Format("2006-01-02 15:04:05")
	fmt.Fprintf(os.Stderr, "[%s] ", timestamp)
	fmt.Fprintf(os.Stderr, format, args...)
}

func main() {
	homeDir, err := os.UserHomeDir()
	if err != nil {
		logError("Error getting home directory: %v\n", err)
		os.Exit(1)
	}

	destDir := filepath.Join(homeDir, "Pictures", "ScreenShots")
	if err := os.MkdirAll(destDir, 0755); err != nil {
		logError("Error creating destination directory: %v\n", err)
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
			logError("Error matching pattern %s: %v\n", pattern, err)
			continue
		}

		for _, file := range matches {
			info, err := os.Stat(file)
			if err != nil {
				logError("Error reading file info %s: %v\n", filepath.Base(file), err)
				failedCount++
				continue
			}

			if info.ModTime().Before(cutoffTime) {
				filename := filepath.Base(file)
				destPath := filepath.Join(destDir, filename)

				if err := moveFile(file, destPath); err != nil {
					logError("Failed to move: %s (%v)\n", filename, err)
					failedCount++
				} else {
					logWithTimestamp("Moved: %s\n", filename)
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

	logWithTimestamp("Script completed. %d file(s) moved, %d failed. %d screenshot(s) remain on desktop.\n",
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

	if _, err := io.Copy(dstFile, srcFile); err != nil {
		dstFile.Close()
		os.Remove(dst)
		return err
	}

	if err := dstFile.Close(); err != nil {
		os.Remove(dst)
		return fmt.Errorf("failed to close destination file: %w", err)
	}

	srcInfo, err := os.Stat(src)
	if err == nil {
		if err := os.Chmod(dst, srcInfo.Mode()); err != nil {
			logError("Warning: failed to set permissions on %s: %v\n", dst, err)
		}
	}

	return os.Remove(src)
}
