#!/bin/sh
# imageshuffle.sh - 7Games - https://github.com/7Games/imageshuffle.sh

input="./"
output="./output.mp4"
timeBetweenImages=5
amountOfImages=10

Help() {
	printf "Usage: imageshuffle.sh [ARGS]...\
	\nSelects images randomly and turns them into a video slideshow.\
	\n\n  -i Input directory                      (Default Value: ./)\
	\n  -o  Output file.                          (Default Value: ./output.mp4)\
	\n  -a  Amount of images in video.            (Default Value: 10)\
	\n  -t  Time between each image in seconds.   (Default Value: 5)\
	\n  -h  Prints this help screen.\n\n"
}

makeSlideshow() {
	image_list="$(find "$input" -type f -regex '.*\(\.jpg\|\.jpeg\|\.png\|\.tiff\)' \
		| sed 's/ /\[:space:\]/g' | shuf -n $amountOfImages)"

	temp_file="$(mktemp)"

	for file in $image_list; do
		printf "file \'%s\'\n" "$(realpath "$(echo "$file" | sed 's/\[:space:\]/ /g')")" >> "$temp_file"
	done

	echo "Generating video, this may take a while..."
	ffmpeg -loglevel fatal -r 1/"$timeBetweenImages" \
		-f concat -safe 0 -i "$temp_file" \
		-vf "scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:-1:-1" -r 30 \
		-vcodec libx264 -crf 18 -pix_fmt yuv420p "$output"

	rm "$temp_file"
}

#Arguments
while getopts ":i:o:a:t:h" option; do
	case $option in
		i)
			input="${OPTARG}" ;;
		o)
			output="${OPTARG}" ;;
		a)
			amountOfImages="${OPTARG}" ;;
		t)
			timeBetweenImages="${OPTARG}" ;;
		*)
			Help && exit ;;
	esac
done

makeSlideshow
