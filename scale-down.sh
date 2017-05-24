#!/bin/bash

# Scale down one or more bitmaps proportionally to match specific
# widths, in pixels, using ImageMagick.
# 
# Suitable for generating images to be used with srcset and sizes.
# 
# See the full documentation on [GitHub](https://github.com/leofavre/scale-down-bitmaps).
# 
# @param {(folder|file)} [s] The source folder or file. Defaults to the current folder.
# @param {folder} [d] The destination folder. Defaults to a folder named "resized" in the current folder.
# @param {string} [w] The widths to resize the bitmaps to, separated by spaces. Defaults to "400 700 900 1100 1400 1700 2000 2300 2700".
# 
# @example
# 
# $ ./scale-down.sh
# 
# $ ./scale-down.sh -s ./bitmaps
# 
# $ ./scale-down.sh -s ./bitmaps/cat.jpg
# 
# $ ./scale-down.sh -s ./bitmaps -d ./output
# 
# $ ./scale-down.sh -s ./bitmaps -w "400 800 1200"
# 
# $ ./scale-down.sh -s ./bitmaps -d ./output -w "400 800 1200"
#
# $ ./scale-down.sh -w "400 800 1200 1600"

while getopts s:d:w: option; do
	case "${option}"
		in
		s ) src=$OPTARG;;
		d ) dest=$OPTARG;;
		w ) wd=$OPTARG;;
	esac
done

saveIFS="$IFS"
IFS=" " widths=($wd)       # Converts `wd` to an array named `width`.
IFS="$saveIFS"

if [[ -d $src ]]; then     # If `src` is a folder...
	cwd=$src
	src=$src/*.*
elif [[ -f $src ]]; then   # Else, if the argument is a file.
	cwd=$(dirname "$src")
fi

src=${src:-./*.*}          # Default `src` value.
cwd=${cwd:-.}              # Default `cwd` value.
dest=${dest:-$cwd/resized} # Default `dest` value.

if [ ${#widths[@]} -eq 0 ]; then
	widths=(400 700 900 1100 1400 1700 2000 2300 2700) # Default `widths` value.
fi

saveIFS=$IFS
IFS=$(echo -en "\n\b")     # Handle filenames with spaces.

for img in $src; do
	for size in ${widths[@]}; do
		width=`magick identify -ping -format "%w" $img` || break

		filename=$(basename "$img")
		ext="${filename##*.}"
		name="${filename%.*}"

		if [ $width -ge $size ]; then
			mkdir -p $dest && magick convert "$img" -resize "${size}" "$dest/$name-$size.$ext"
		fi
	done
done

IFS="$saveIFS"
