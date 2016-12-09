STATIC_FFMPEG_URL := "https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-64bit-static.tar.xz"

.PHONY: all
all: docker

build/sbin/nginx: nginx/objs/nginx
	mkdir -p build/sbin && cp nginx/objs/nginx build/sbin/nginx

nginx/objs/nginx:
	cd nginx && \
		./auto/configure \
		--prefix= \
		--sbin-path=/sbin/nginx \
		--conf-path=/etc/nginx.conf \
		--pid-path=/tmp/nginx.pid \
		--lock-path=/tmp/nginx.lock \
		--error-log-path=/dev/stderr \
		--http-log-path=/dev/stdout \
		--http-client-body-temp-path=/tmp \
		--http-proxy-temp-path=/tmp \
		--with-cc-opt="-static -static-libgcc" --with-ld-opt="-static" --with-cpu-opt=generic \
		--add-module=../nginx-rtmp-module \
		$$(./auto/configure --help | grep without | awk '{print $$1}' | grep -v '^--without-http$$' | grep -v '^--without-select_module$$' | grep -v '^--without-poll_module$$')
	$(MAKE) -C nginx

build/bin/ffmpeg: ffmpeg-release-64bit-static.tar.xz
	mkdir -p build/bin && tar xvpf ffmpeg-release-64bit-static.tar.xz -C build/bin --strip 1 ffmpeg-3.2.1-64bit-static/ffmpeg && touch build/bin/ffmpeg

ffmpeg-release-64bit-static.tar.xz:
	wget "${STATIC_FFMPEG_URL}" -O $@

build/etc/nginx.conf: nginx.conf
	mkdir -p build/etc && cp nginx.conf build/etc/nginx.conf

build/bin/publish: publish
	mkdir -p build/bin && cp publish build/bin/publish

build/bin/daemon: daemon
	mkdir -p build/bin && cp daemon build/bin/daemon

build/Dockerfile: Dockerfile
	mkdir -p build && cp Dockerfile build/Dockerfile

.PHONY: docker
docker: build/sbin/nginx build/bin/ffmpeg build/etc/nginx.conf build/bin/publish build/bin/daemon build/Dockerfile
	docker build -t ziyan/livebox build

.PHONY: clean
clean:
	rm -rf build
