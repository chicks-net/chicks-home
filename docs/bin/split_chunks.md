# split_chunks

Split a video into 28-second chunks starting every 10 seconds.

## Synopsis

```bash
split_chunks <input-video> [output-dir]
```

## Description

`split_chunks` is a bash script (strict mode) that uses `ffmpeg -c copy`
(stream copy, fast, keyframe-snapped) to split an MP4 (or any
ffmpeg-readable video) into 28-second chunks, with a new chunk starting
every 10 seconds. This produces overlapping segments that are useful for
sliding-window analysis, previews, or feeding into another pipeline that
needs multiple looks at each moment of the source.

It skips starts within the final 28 seconds so only full-length chunks are
emitted (no tiny tail clips).

Output files are named `<stem>_start-<N>s.mp4`, where `<N>` is the start
offset in seconds and `<stem>` is the input filename stem.

## Requirements

- `ffmpeg`
- `ffprobe`

## Arguments

| Argument | Description |
| --- | --- |
| `input-video` | Path to the source video. Required. |
| `output-dir` | Directory to write chunks into. Optional (defaults to CWD). |

## Examples

```bash
split_chunks recording.mp4
split_chunks recording.mp4 ./chunks
```

## See Also

- [youtube2mp3.md](youtube2mp3.md) - another ffmpeg-driven utility
