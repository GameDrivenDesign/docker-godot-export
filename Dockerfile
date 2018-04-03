#
# Set EXPORT_NAME to your template's name and OUTPUT_FILENAME accordingly.
# Add two volumes, one from your repository to /build/src and another to
# /build/output where the product will be stored.
#
# E.g. inside your game's main folder (find the product in /tmp/output):
#
# docker run \
#	-e EXPORT_NAME="HTML5" \
#	-e OUTPUT_FILENAME="index.html" \
#	-v $(pwd):/build/src -v /tmp/output:/build/output gamedrivendesign/godot-export

FROM alpine:edge

WORKDIR /build

RUN apk --no-cache add ca-certificates wget

RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
	&& wget -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.27-r0/glibc-2.27-r0.apk \
	&& apk add glibc-2.27-r0.apk

RUN wget -q --waitretry=1 --retry-connrefused -T 10 https://downloads.tuxfamily.org/godotengine/3.0.2/Godot_v3.0.2-stable_linux_server.64.zip -O /tmp/godot.zip \
	&& unzip -q -d /tmp /tmp/godot.zip \
	&& mv /tmp/Godot* /build/godot

RUN wget -q --waitretry=1 --retry-connrefused -T 10 https://downloads.tuxfamily.org/godotengine/3.0.2/Godot_v3.0.2-stable_export_templates.tpz -O /tmp/export-templates.tpz \
	&& mkdir -p /tmp/data/godot/templates \
	&& unzip -q -d /tmp/data/godot/templates /tmp/export-templates.tpz \
	&& mv /tmp/data/godot/templates/templates /tmp/data/godot/templates/3.0.2.stable

ENV XDG_CACHE_HOME /tmp/cache
ENV XDG_DATA_HOME /tmp/data
ENV XDG_CONFIG_HOME /tmp/config
RUN mkdir -p /tmp/cache && mkdir -p /tmp/data && mkdir -p /tmp/config

ENV EXPORT_NAME HTML5
ENV OUTPUT_FILENAME index.html

CMD ["sh", "-c", "/build/godot --export \"${EXPORT_NAME}\" --path /build/src \"/build/output/${OUTPUT_FILENAME}\""]
