#!/bin/bash
c=0
ORIGINALS=$(ls originals/*)
echo "originals: $ORIGINALS"
for f in $ORIGINALS
do
	((c++))
	echo $f
	g=${f##*/}
	echo $g
	h=${g%.*}
	echo $h

	#ffmpeg -y -i $f -r 30 -vcodec libx264 -pix_fmt yuv420p -vprofile main -preset slower -b:v 3200k -maxrate 6400k -bufsize 12800k -x264opts keyint=60:min-keyint=60:scenecut=-1 -vf "scale=trunc(oh*a/2)*2:1080" -threads 0 -acodec aac -strict -2 -ac 2 -ab 128k -ar 44100 ./transcoded/"$h"_1080p.mp4
	#ffmpeg -y -i $f -r 30 -vcodec libx264 -pix_fmt yuv420p -vprofile main -preset slower -b:v 1600k -maxrate 3200k -bufsize 6400k -x264opts keyint=60:min-keyint=60:scenecut=-1 -vf "scale=trunc(oh*a/2)*2:720" -threads 0 -acodec aac -strict -2 -ac 2 -ab 128k -ar 44100 ./transcoded/"$h"_720p.mp4
	#ffmpeg -y -i $f -r 30 -vcodec libx264 -pix_fmt yuv420p -vprofile main -preset slower -b:v 1000k -maxrate 2000k -bufsize 4000k -x264opts keyint=60:min-keyint=60:scenecut=-1 -vf "scale=trunc(oh*a/2)*2:480" -threads 0 -acodec aac -strict -2 -ac 2 -ab 128k -ar 44100 ./transcoded/"$h"_480p.mp4
	#ffmpeg -y -i $f -r 30 -vcodec libx264 -pix_fmt yuv420p -vprofile main -preset slower -b:v 600k -maxrate 1200k -bufsize 2400k -x264opts keyint=60:min-keyint=60:scenecut=-1 -vf "scale=trunc(oh*a/2)*2:360" -threads 0 -acodec aac -strict -2 -ac 2 -ab 128k -ar 44100 ./transcoded/"$h"_360p.mp4
	#ffmpeg -y -i $f -r 30 -vcodec libx264 -pix_fmt yuv420p -vprofile main -preset slower -b:v 300k -maxrate 600k  -bufsize 1200k  -x264opts keyint=60:min-keyint=60:scenecut=-1 -vf "scale=trunc(oh*a/2)*2:240" -threads 0 -acodec aac -strict -2 -ac 2 -ab 128k -ar 44100 ./transcoded/"$h"_240p.mp4
	#ffmpeg -y -i $f -r 30 -vcodec libx264 -pix_fmt yuv420p -vprofile main -preset slower -b:v 150k -maxrate 300k  -bufsize 600k  -x264opts keyint=60:min-keyint=60:scenecut=-1 -vf "scale=trunc(oh*a/2)*2:160" -threads 0 -acodec aac -strict -2 -ac 1 -ab 128k -ar 44100 ./transcoded/"$h"_160p.mp4
	cp ./assets/template.json ./transcoded/"$h"
	sed -i -e s/filename/"$h"/g ./transcoded/"$h"
done
