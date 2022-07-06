#!/bin/bash
#imageshuffle.sh ~ 7Games ~ https://github.com/7Games/image-shuffle

output="./output.mp4"
timeBetweenImages=5
amountOfImages=10

Help() {
#Display Help
	echo "Takes images and turns them into a video slideshow."
	echo
	echo "Syntax: imageshuffle.sh [ARGS]"
	echo "options:"
	echo "o   Output file.               		(Default Value: ./output.mp4)"
	echo "a   Amount of images in video. 		(Default Value: 10)"
	echo "t   Time between each image in seconds.	(Default Value: 5)"
	echo "h   Prints this help screen."
	echo
}

makeSlideshow() {
	#Removes the imgtmp directory then creates a new one
	mkdir ./imgtmp
	
	#Gets random files with the [.png, .jpg, .jpeg] extention and copys them into the imgtmp directory
	ls | grep -e .jpg -e .jpeg -e .png | shuf -n $amountOfImages | xargs -I % cp % ./imgtmp/

	for i in ./imgtmp/*; do
		filename=$((RANDOM * 32768 + RANDOM))
		mv "$i" ./imgtmp/$filename
	done

	echo "Generating video..."
	#Creates the slide show with imgtmp as the input.
	cat ./imgtmp/* | ffmpeg -hide_banner -loglevel error -f image2pipe -framerate 1/$timeBetweenImages -i - -pix_fmt yuv444p -vf 'scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2,setsar=1' -r 30 "$output"
	
	#Removes the imgtmp directory
	rm -rf ./imgtmp
}

#Arguments
while getopts ":o:a:t:h" option; do
	case $option in
		o)					#Output
			output=${OPTARG};;
		a)					#Amount of images
                        amountOfImages=${OPTARG};;
		t)					#Time between images
                        timeBetweenImages=${OPTARG};;
		h)
			Help
			exit;;
	esac
done

makeSlideshow
