# Description

A powershell script to chop a video into time fragments.

# Usage

`script.ps1 <input> <start1> <end1> [<start2> <end2> ...]`

Where input is your video file and each pair start-end is in a format of HH:MM:SS.ms, milliseconds optional.

Creates fragments video files with names `<input>-chop%i.mp4`, where <input> is the input filename minus extension and `%i` is the number of the fragment.

# Note

- This script works with mp4 files, but it is easy to alter.
- It copies the i-frames to avoid recoding and thus making the chops lossless to the original.
- Due to this, the start shifts to the beginning of the i-frame. You will sometimes see that a chop starts before your specified start point. Recode or shift the start point further a bit.
