# Image
FROM alpine:3.9

# Copy patches
RUN mkdir -p /tmp/patches
COPY conf/* /tmp/patches/

# Install needed packages
RUN apk add --no-cache \
  bash \
  openjdk8-jre \
  jq \
  curl \
  openssl \
  libstdc++ \
  libx11 \
  libxrender \
  libxext \
  ca-certificates \
  fontconfig \
  freetype \
  ttf-dejavu \
  ttf-droid \
  ttf-freefont \
  ttf-liberation \
  ttf-ubuntu-font-family \
&& apk add --no-cache --virtual .build-deps \
  g++ \
  git \
  gtk+ \
  gtk+-dev \
  make \
  mesa-dev \
  openssl-dev \
  patch \

# Download source files
&& git clone --recursive --depth 1 https://github.com/wkhtmltopdf/wkhtmltopdf.git /tmp/wkhtmltopdf \

# Apply patches
&& cd /tmp/wkhtmltopdf \
&& patch -i /tmp/patches/wkhtmltopdf-buildconfig.patch \
&& cd /tmp/wkhtmltopdf/qt \
&& patch -p1 --ignore-whitespace -F4 -i /tmp/patches/qt-musl.patch \
&& patch -p1 --ignore-whitespace -F4 -i /tmp/patches/qt-musl-iconv-no-bom.patch \
&& patch -p1 --ignore-whitespace -F4 -i /tmp/patches/qt-recursive-global-mutex.patch \
&& patch -p1 --ignore-whitespace -F4 -i /tmp/patches/improve-cups-support.patch \
&& patch -p1 --ignore-whitespace -F4 -i /tmp/patches/moc-boost-workaround.patch \
&& patch -p1 --ignore-whitespace -F4 -i /tmp/patches/qt4-glibc-2.25.patch \
&& patch -p1 --ignore-whitespace -F4 -i /tmp/patches/qt4-icu59.patch \

# Modify qmake config
&& echo "QMAKE_CXXFLAGS += -std=gnu++98" >> src/3rdparty/javascriptcore/JavaScriptCore/JavaScriptCore.pri \
&& echo "QMAKE_CXXFLAGS += -std=gnu++98" >> src/plugins/accessible/qaccessiblebase.pri \
&& sed -i "s|-O2|${CXXFLAGS}|" mkspecs/common/g++-base.conf \
&& sed -i "s|-O2|${CXXFLAGS}|" mkspecs/common/gcc-base.conf \
&& sed -i "/^QMAKE_LFLAGS_RPATH/s| -Wl,-rpath,||g" mkspecs/common/gcc-base-unix.conf \
&& sed -i "/^QMAKE_LFLAGS\s/s|+=|+= ${LDFLAGS}|g" mkspecs/common/gcc-base.conf \

# Prepare optimal build settings
&& NB_CORES=$(grep -c '^processor' /proc/cpuinfo) \

# Install qt
&& ./configure -confirm-license -opensource \
  -prefix /usr \
  -datadir /usr/share/qt \
  -sysconfdir /etc \
  -plugindir /usr/lib/qt/plugins \
  -importdir /usr/lib/qt/imports \
  -silent \
  -release \
  -static \
  -webkit \
  -script \
  -svg \
  -exceptions \
  -xmlpatterns \
  -openssl-linked \
  -no-fast \
  -no-largefile \
  -no-accessibility \
  -no-stl \
  -no-sql-ibase \
  -no-sql-mysql \
  -no-sql-odbc \
  -no-sql-psql \
  -no-sql-sqlite \
  -no-sql-sqlite2 \
  -no-qt3support \
  -no-opengl \
  -no-openvg \
  -no-system-proxies \
  -no-multimedia \
  -no-audio-backend \
  -no-phonon \
  -no-phonon-backend \
  -no-javascript-jit \
  -no-scripttools \
  -no-declarative \
  -no-declarative-debug \
  -no-neon \
  -no-rpath \
  -no-nis \
  -no-cups \
  -no-pch \
  -no-dbus \
  -no-separate-debug-info \
  -no-gtkstyle \
  -no-nas-sound \
  -no-opengl \
  -no-openvg \
  -no-sm \
  -no-xshape \
  -no-xvideo \
  -no-xsync \
  -no-xinerama \
  -no-xcursor \
  -no-xfixes \
  -no-xrandr \
  -no-mitshm \
  -no-xinput \
  -no-xkb \
  -no-glib \
  -no-icu \
  -nomake demos \
  -nomake docs \
  -nomake examples \
  -nomake tools \
  -nomake tests \
  -nomake translations \
  -graphicssystem raster \
  -qt-zlib \
  -qt-libpng \
  -qt-libmng \
  -qt-libtiff \
  -qt-libjpeg \
  -optimized-qmake \
  -iconv \
  -xrender \
  -fontconfig \
  -D ENABLE_VIDEO=0 \
&& make --jobs $(($NB_CORES*2)) --silent 1>/dev/null \
&& make install \

# Install wkhtmltopdf
&& cd /tmp/wkhtmltopdf \
&& qmake \
&& make --jobs $(($NB_CORES*2)) --silent 1>/dev/null \
&& make install \
&& make clean \
&& make distclean \

# Uninstall qt
&& cd /tmp/wkhtmltopdf/qt \
&& make uninstall \
&& make clean \
&& make distclean \

# Clean up when done
&& rm -rf /tmp/* \
&& apk del .build-deps
