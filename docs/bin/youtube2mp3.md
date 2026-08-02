# youtube2mp3

Download a YouTube video and transcode it to MP3.

## Synopsis

```bash
youtube2mp3 <url> <output-name>
```

## Description

`youtube2mp3` is a Bash script that downloads a YouTube video and converts
it to MP3. It:

1. Creates `~/tmp` and `~/Music/from_youtube` if they don't exist.
2. Downloads the video with `youtube-dl` (format 18 / FLV) to a temp file.
3. Transcodes with `ffmpeg` using `libmp3lame`, stereo, 128k.

The temp FLV file is intentionally left in place (the `rm` line is commented
out), which is useful if you want to re-encode later at a different bitrate
or with different options.

## Requirements

- `youtube-dl` (or a compatible fork such as `yt-dlp` aliased to `youtube-dl`)
- `ffmpeg`

## Arguments

| Argument | Description |
| --- | --- |
| `url` | YouTube video URL to download. Required. |
| `output-name` | Base name for the output MP3 (extension added by script). Required. |

## Examples

```bash
youtube2mp3 'https://www.youtube.com/watch?v=dQw4w9WgXcQ' rick
# Produces ~/Music/from_youtube/rick.mp3
```

## See Also

- [split_chunks.md](split_chunks.md) - another ffmpeg-driven utility
