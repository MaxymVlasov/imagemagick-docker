FROM alpine:3.12 as deps

# Install dependencies
RUN apk add --no-cache \
        fontconfig \
        freetype \
        ghostscript \
        ghostscript-fonts \
        lcms2 \
        libgomp \
        libjpeg-turbo \
        libpng \
        libwebp \
        openexr \
        tiff \
        x265 \
        zlib



FROM deps as builder

#
# Git repos versioning
#
ARG LIBDE265_COMMIT=43c490812a6c7b78e9d73125c7e4e2d6ee9826d2
ARG LIBHEIF_COMMIT=0c49d5b4882bcbfc0279dede005832367eb83397
ARG IMAGEMAGICK_COMMIT=fa87fa7287c8275f52b508770c814815ebe61a02


RUN apk add --no-cache \
        alpine-sdk \
        autoconf \
        automake \
        bash \
        libtool

# Install dev versions
RUN apk add --no-cache \
        fontconfig-dev \
        freetype-dev \
        ghostscript-dev \
        lcms2-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libwebp-dev \
        openexr-dev \
        tiff-dev \
        x265-dev \
        zlib-dev

WORKDIR /work
RUN git clone -b frame-parallel https://github.com/strukturag/libde265.git \
    && cd libde265 \
    && git checkout ${LIBDE265_COMMIT} .


WORKDIR /work/libde265
RUN ./autogen.sh \
    && ./configure \
    && make -j8 install


WORKDIR /work
RUN git clone https://github.com/strukturag/libheif.git \
    && cd libheif \
    && git checkout ${LIBHEIF_COMMIT} .

WORKDIR /work/libheif
RUN ./autogen.sh \
    && ./configure \
    && make -j8 install


WORKDIR /work
RUN git clone https://github.com/ImageMagick/ImageMagick.git \
    && cd ImageMagick \
    && git checkout ${IMAGEMAGICK_COMMIT} .

WORKDIR /work/ImageMagick
RUN ./configure \
        --with-heic \
        --with-jpeg \
        --with-lcms2 \
        --with-png \
        --with-gslib \
        --with-openexr \
        --with-tiff \
        --with-zlib \
        --with-gs-font-dir=/usr/share/fonts/Type1 \
        --with-threads \
        --with-webp \
        --without-x \
        --disable-cipher \
        --without-magick-plus-plus \
        --without-pango \
        --without-perl
RUN make -j8 install



FROM deps
#
# Copy ImageMagick binaries to image with dependencies
#
COPY --from=builder /usr/local/lib/libde265.so.1 /usr/local/lib/libde265.so.1
COPY --from=builder /usr/local/lib/libheif.so.1 /usr/local/lib/libheif.so.1

COPY --from=builder /usr/local/lib/libMagickCore-7.Q16HDRI.so /usr/local/lib/libMagickCore-7.Q16HDRI.so.7
COPY --from=builder /usr/local/lib/libMagickWand-7.Q16HDRI.so /usr/local/lib/libMagickWand-7.Q16HDRI.so.7
COPY --from=builder /usr/local/lib/ImageMagick-7.0.10/ /usr/local/lib/ImageMagick-7.0.10/
COPY --from=builder /usr/local/etc/ImageMagick-7/ /usr/local/etc/ImageMagick-7/
COPY --from=builder /usr/local/bin/magick /usr/local/bin/magick

RUN ln -s /usr/local/bin/magick /usr/local/bin/convert

ENTRYPOINT [ "/usr/local/bin/convert" ]
