#!/bin/bash
# a script to turn folders of jpegs into bootstrap carouselz
# TODO: there probably doesn't need to be a billion for loops, but oh well

# config yo
INPUT=/Users/mjleino/Dropbox/Nettisivut
OUTPUT_IMG=/Users/mjleino/Dropbox/VIIXXIPOJAT/KONSTRU/www/static/refe
OUTPUT_HTML=/Users/mjleino/Dropbox/VIIXXIPOJAT/KONSTRU/www

cd $INPUT
for dir in [1-5]_*; do 
	cd $dir
	rm $OUTPUT_HTML/$dir.html
	for subdir in *; do
		subdir_=$(echo $subdir | sed -e 's/ /_/g;s/̈//g')
		mkdir -p $OUTPUT_IMG/$dir/$subdir_
		cd "$subdir"

		# poop html
		count=$(ls * | wc -l)
		((count>1)) && cat <<HEADER >> $OUTPUT_HTML/$dir.html
<div id="$subdir_" class="carousel slide">
  <ol class="carousel-indicators">
HEADER
		((count>1)) && printf "    <li data-target='#$subdir_' data-slide-to='0' class='active'></li>\n" >> $OUTPUT_HTML/$dir.html
		((count>1)) && printf "    <li data-target='#$subdir_' data-slide-to='%d'></li>\n" $(seq 1 $((count-1))) >> $OUTPUT_HTML/$dir.html
		((count>1)) && cat <<MIDDLEPART >> $OUTPUT_HTML/$dir.html
  </ol>
MIDDLEPART
		cat <<ALWAYS >> $OUTPUT_HTML/$dir.html
  <div class="carousel-inner" role="listbox">
ALWAYS
		class="item active"
		for jpeg in *; do
			jpeg_=$(echo $jpeg | sed -e 's/ /_/g;s/̈//g')
			echo "    <div class='$class'><img src='{{ \"/static/refe/$dir/$subdir_/$jpeg_\" | prepend: site.baseurl }}'></div>" >> $OUTPUT_HTML/$dir.html
			class="item"
		done
		cat <<ALWAYSTWO >> $OUTPUT_HTML/$dir.html
  </div>
ALWAYSTWO
		((count>1)) && cat <<FOOTER >> $OUTPUT_HTML/$dir.html 
  <a class="left carousel-control" href="#$subdir_" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Edellinen</span>
  </a>
  <a class="right carousel-control" href="#$subdir_" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Seuraava</span>
  </a>
</div>

FOOTER

		echo OTSIKKO_$subdir_ >> $OUTPUT_HTML/$dir.html
		echo >> $OUTPUT_HTML/$dir.html

		# poop properly sized images
		for jpeg in *; do
			jpeg_=$(echo $jpeg | sed -e 's/ /_/g;s/̈//g')
			# convert -resize 940x $INPUT/$dir/"$subdir"/"$jpeg" $OUTPUT_IMG/$dir/$subdir_/$jpeg_
		done
		cd ..
	done
	cd ..
done
