@echo off
for /r %%F in (originals/*) do (
	echo %%F
	echo %%~dpF
    echo %%~nxF
    echo %%~nF
    echo %%~xF
	
	call assets/repl.bat "filename" "%%~nF" L < "assets/template.json" >"transcoded/%%~nF"

	ffmpeg -y -i originals/%%~nxF -r 30 -vcodec libx264 -pix_fmt yuv420p -vprofile main -preset slower -b:v 3200k -maxrate 6400k -bufsize 12800k -x264opts keyint=60:min-keyint=60:scenecut=-1 -vf "scale=trunc(oh*a/2)*2:1080" -threads 0 -acodec aac -strict -2 -ac 2 -ab 128k -ar 44100 transcoded/%%~nF_1080p.mp4
	ffmpeg -y -i originals/%%~nxF -r 30 -vcodec libx264 -pix_fmt yuv420p -vprofile main -preset slower -b:v 1600k -maxrate 3200k -bufsize 6400k -x264opts keyint=60:min-keyint=60:scenecut=-1 -vf "scale=trunc(oh*a/2)*2:720" -threads 0 -acodec aac -strict -2 -ac 2 -ab 128k -ar 44100 ./transcoded/%%~nF_720p.mp4
	ffmpeg -y -i originals/%%~nxF -r 30 -vcodec libx264 -pix_fmt yuv420p -vprofile main -preset slower -b:v 1000k -maxrate 2000k -bufsize 4000k -x264opts keyint=60:min-keyint=60:scenecut=-1 -vf "scale=trunc(oh*a/2)*2:480" -threads 0 -acodec aac -strict -2 -ac 2 -ab 128k -ar 44100 ./transcoded/%%~nF_480p.mp4
	ffmpeg -y -i originals/%%~nxF -r 30 -vcodec libx264 -pix_fmt yuv420p -vprofile main -preset slower -b:v 600k -maxrate 1200k -bufsize 2400k -x264opts keyint=60:min-keyint=60:scenecut=-1 -vf "scale=trunc(oh*a/2)*2:360" -threads 0 -acodec aac -strict -2 -ac 2 -ab 128k -ar 44100 ./transcoded/%%~nF_360p.mp4
	ffmpeg -y -i originals/%%~nxF -r 30 -vcodec libx264 -pix_fmt yuv420p -vprofile main -preset slower -b:v 300k -maxrate 600k  -bufsize 1200k  -x264opts keyint=60:min-keyint=60:scenecut=-1 -vf "scale=trunc(oh*a/2)*2:240" -threads 0 -acodec aac -strict -2 -ac 2 -ab 128k -ar 44100 ./transcoded/%%~nF_240p.mp4
	ffmpeg -y -i originals/%%~nxF -r 30 -vcodec libx264 -pix_fmt yuv420p -vprofile main -preset slower -b:v 150k -maxrate 300k  -bufsize 600k  -x264opts keyint=60:min-keyint=60:scenecut=-1 -vf "scale=trunc(oh*a/2)*2:160" -threads 0 -acodec aac -strict -2 -ac 1 -ab 128k -ar 44100 ./transcoded/%%~nF_160p.mp4
)