#!/bin/bash
#imageshuffle.sh ~ 7Games ~ https://github.com/7Games/image-shuffle

input="./"
output="./output.mp4"
timeBetweenImages=5
amountOfImages=10

Help() {
#Display Help
	echo "Takes images and turns them into a video slideshow."
	echo
	echo "Syntax: imageshuffle.sh [-i|o|a|t|vf|vw|vh|h]"
	echo "options:"
	echo "i   Input directory.           (Default Value: $input)"
	echo "o   Output file.               (Default Value: $output)"
	echo "a   Amount of images in video. (Default Value: $timeBetweenImages)"
	echo "t   Time between each image.   (Default Value: $amountOfImages)"
	echo "h   Prints this help screen."
	echo
}

makeSlideshow() {
	#Removes the imgtmp directory then creates a new one
	mkdir $input/imgtmp

	#Gets random files with the [.png, .jpg, .jpeg] extention and copys them into the imgtmp directory
	ls $input | grep -e .jpg -e .jpeg -e .png | shuf -n $amountOfImages | xargs -I % cp % $input/imgtmp/

	for i in $input/imgtmp/*; do
		filename=$((RANDOM * 32768 + RANDOM))
		mv "$i" $input/imgtmp/$filename
	done

	echo "Createing video..."
	#Creates the slide show with imgtmp as the input.
	cat $input/imgtmp/* | ffmpeg -hide_banner -loglevel error -f image2pipe -framerate 1/$timeBetweenImages -i - -pix_fmt yuv444p -vf 'scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2,setsar=1' -r 30 "$output"
	
	#Removes the imgtmp directory
	rm -rf $input/imgtmp
}

function rand_string {
    local c=$1 ret=
    while((c--)); do
        ret+=${chars[$((RANDOM%${#chars[@]}))]}
    done
    printf '%s\n' "$ret"
}

while getopts ":i:o:a:t:h:" option; do
	case $option in
		h) 					#Display Help
			Help
			exit;;
		o)					#Output
			output=${OPTARG};;
		i)					#Input
			input=${OPTARG};;
		a)					#Amount of images
                        amountOfImages=${OPTARG};;
		t)					#Time between images
                        timeBetweenImages=${OPTARG};;
	esac
done

makeSlideshow
