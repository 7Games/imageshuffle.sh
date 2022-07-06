## imageshuffle.sh

A bash script that takes a random selection of images and turns it into a video slideshow.

---------
### Dependencies
- bash
- ffmpeg

### How to install
1) Clone the repo<br>
`$ git clone https://github.com/7Games/image-shuffle && cd image-shuffle`


2) Run the install command<br>
`$ sudo make install`


3) Run the command
```
$ imageshuffle.sh
Takes images and turns them into a video slideshow.

Syntax: imageshuffle.sh [-i|o|a|t|h]
options:
i   Input directory.
o   Output file.
a   Amount of images in video.
t   Time between each image.
h   Prints this help screen.
```
---------

### Usage
`$ imageshuffle.sh -a 30 -t 5 -i ./ -o ./output.mp4`

The process may take a while depending on how many image you choose and the duration of each image is.

---------

Made by [7Games](https://sevengames.xyz).<br>
[LICENSE](https://github.com/7Games/image-shuffle/blob/main/LICENSE)
