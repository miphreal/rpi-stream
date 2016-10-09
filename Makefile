stream:
	ffmpeg \
	-r 15 -f x11grab -s 1920x1080 -i :0.0 \
	-c:v libx264    -pix_fmt yuv420p \
	-preset veryfast -tune zerolatency \
	-bsf:v h264_mp4toannexb -b:v 5000k \
	-bufsize 500k -f mpegts \
	udp://192.168.0.118:9991

rpi-receiver:
	ssh -Y pi@192.168.0.118 "\
	while true; do \
		omxplayer \
		-b \
		--live \
		udp://0.0.0.0:8888; \
	done"