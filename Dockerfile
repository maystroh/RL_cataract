#An optimized tensorflow version 1.8 to support faster CPU computation. Here is my reference (https://github.com/mind/wheels) https://github.com/yaroslavvb/tensorflow-community-wheels/issues
FROM tinymind/tensorflow:1.8-py36-gpu

# ensure local python is preferred over distribution python
ENV PATH /usr/local/bin:$PATH

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		libexpat1 \
		libffi6 \
		libgdbm3 \
		libreadline6 \
		libsqlite3-0 \
		libssl1.0.0 \
	&& rm -rf /var/lib/apt/lists/*

#ENV GPG_KEY 0D96DF4D4110E5C43FBFB17F2D347EA6AA65421D
#ENV PYTHON_VERSION 3.6.4

RUN set -ex \
	&& buildDeps=" \
		dpkg-dev \
		gcc \
		libbz2-dev \
		libc6-dev \
		libexpat1-dev \
		libffi-dev \
		libgdbm-dev \
		liblzma-dev \
		libncursesw5-dev \
		libreadline-dev \
		libsqlite3-dev \
		libssl-dev \
		make \
		tcl-dev \
		tk-dev \
		wget \
		xz-utils \
		zlib1g-dev \
		$(command -v gpg > /dev/null || echo 'gnupg dirmngr') \
	" \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* 

# make some useful symlinks that are expected to exist
RUN cd /usr/local/bin \
	&& ln -s idle3 idle \
	&& ln -s pydoc3 pydoc \
	&& ln -s python3 python \
	&& ln -s python3-config python-config

# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"
ENV PYTHON_PIP_VERSION 19.1

RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y --no-install-recommends wget; \
	rm -rf /var/lib/apt/lists/*; \
	\
	wget -O get-pip.py 'https://bootstrap.pypa.io/get-pip.py'; \
	\
	apt-get purge -y --auto-remove wget; \
	\
	python get-pip.py \
		--disable-pip-version-check \
		--no-cache-dir \
		"pip==$PYTHON_PIP_VERSION" \
	; \
	pip --version; \
	\
	find /usr/local -depth \
		\( \
			\( -type d -a \( -name test -o -name tests \) \) \
			-o \
			\( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
		\) -exec rm -rf '{}' +; \
	rm -f get-pip.py

RUN apt-get update && apt-get -y upgrade
# xvfb is used to do CPU based rendering of Unity
RUN apt-get install -y xvfb libgomp1 mesa-utils libxrender-dev openmpi-bin libopenmpi-dev

COPY ml-agents /ml-agents
WORKDIR /ml-agents
RUN pip3 install .

RUN pip3 install gym
RUN pip3 install opencv-python
RUN pip3 install joblib
RUN pip3 install Cython
RUN pip3 install mpi4py
RUN pip3 install cloudpickle

RUN pip3 install pytest
RUN pip3 install pytest-cov
RUN pip3 install cloudpickle
RUN pip3 install box2d-py
RUN pip3 install pybullet
RUN pip3 install pytablewriter
RUN pip3 install stable-baselines
RUN pip3 install psutil
