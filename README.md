## imageshuffle.sh

A POSIX shell script that takes a random selection of images and turns it into a video slideshow.

---------
### Dependencies
- POSIX shell
- sed
- shuf
- ffmpeg

### How to install
1) Clone the repo<br>
`$ git clone https://github.com/7Games/imageshuffle.sh && cd imageshuffle.sh`

2) Move it to anywhere you like, such as your ```~/.local/bin``` directory.

3) Run the command
```
$ imageshuffle.sh -h
Takes images and turns them into a video slideshow.

Syntax: imageshuffle.sh [ARGS]
options:
  -i   Input directory.                     (Default Value: ./)
  -o   Output file.                         (Default Value: ./output.mp4)
  -a   Amount of images in video.           (Default Value: 10)
  -t   Time between each image in seconds.  (Default Value: 5)
  -h   Prints this help screen.
```
---------

### Usage
`$ imageshuffle.sh -i "$HOME/Pictures" -a 30 -t 5 -o ./output.mp4`

The process may take a while depending on how many image you choose and the duration of each image is.

---------

Made by [7Games](https://sevengames.xyz).<br>
[LICENSE](https://github.com/7Games/image-shuffle/blob/main/LICENSE)
