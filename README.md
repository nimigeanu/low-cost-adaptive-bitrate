# Low-Cost AWS Adaptive Bitrate VOD Streaming Architecture

## Features

* All-AWS setup
* Stream directly from S3
* Scripts to manually transcode your video library to ABR - for Windows and Mac/Linux
* Ultra-light Nginx-based on-the-fly HLS packager (https://github.com/kaltura/nginx-vod-module)
* Lightning fast, 4 levels of caching
* CDN delivery
* Works with any HLS-capable player


## Setup

### Transcoding your video library

1. install [`ffmpeg`](http://ffmpeg.org/download.html) on your designated transcoder computer
2. clone this repository on your transcoder computer
3. copy your video files in the `transcode/originals/` folder
4. execute `transcode/transcode_all.sh` (Mac/Linux) or `transcode/transcode_all.cmd` (Windows)
5. wait for transcoding to complete; expect this to take 10-12 minutes<sup>(1)</sup> for every minute of content
6. you will find your transcoded files and ABR manifests in the `transcode/transcoded` folder; upload all files to an S3 bucket of your choice

<sup>(1)</sup>wait time can be reduced at the expense of quality by changing the preset (i.e. from 'slower' to 'slow', 'medium', 'fast', 'faster' etc); GPU accelerated transcoding is also possible

### Setup the packager server

1. launch a (nano or micro) [ubuntu](https://cloud-images.ubuntu.com/locator/ec2) EC2 instance 
2. connect to your instance via SSH
3. compile and install `Nginx` with required modules as following:
```bash
git clone https://github.com/kaltura/nginx-vod-module
git clone https://github.com/Nextdoor/ngx_aws_auth
sudo apt-get install build-essential libpcre3 libpcre3-dev libssl-dev zlib1g-dev
wget http://nginx.org/download/nginx-1.15.9.tar.gz
tar -xf nginx-1.15.9.tar.gz
cd nginx-1.15.9/
./configure --with-http_ssl_module --add-module=../nginx-vod-module --add-module=../ngx_aws_auth
sudo make install
```
4. replace `/usr/local/nginx/conf/nginx.conf` with the provided `nginx/nginx.conf`
5. in your newly replaced `/usr/local/nginx/conf/nginx.conf`, change '*your_bucket_name*' with the actual name of the S3 bucket holding your content (lines 53 and 56)
6. in your newly replaced `/usr/local/nginx/conf/nginx.conf`, change '*your_access_key*' and '*your_secret_key*' with the access and secret keys of an AWS user with access to the S3 bucket; alternatively, remove lines 54-58 if your bucket is public
7. start your nginx server
```bash
sudo /usr/local/nginx/sbin/nginx
```

### Setup CloudFront

Create a `Web` type CloudFront distribution with the following features:
* Origin Domain Name: the `Public DNS (IPv4)` of the EC2 instance you just set up
* Origin Protocol Policy: `HTTP Only`
* Allowed HTTP Methods: `GET, HEAD, OPTIONS`

(leave all other settings to default)

## Linking to your ABR content

Use the following format to compose your HLS link:

	http(s)://{CloudFront_distribution_id}.cloudfront.net/{video_filename_without_extension}/master.m3u8

e.g. if your CloudFront distribution is 'd32wx2nxsaxxxx' and your (original) video file is 'sample.mkv', your URL would be

https://d32wx2nxsaxxxx.cloudfront.net/sample/master.m3u8

## Player

Both [Clappr](http://clappr.io/) and [Video.js](https://videojs.com/) are free and have long had good support for HLS.

Alternatively, [HLS.js](https://github.com/video-dev/hls.js/) is a library that can be used to create or extend your own player, with advanced usage scenarios. Also free.

