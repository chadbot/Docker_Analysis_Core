# start with version-stable R image (built on Ubuntu)
FROM rocker/r-ver:latest

# args for volume permissions - can specify these at build time to match user's id and group (id -u and id -g)
ARG USERNAME=user
ARG USER_ID=1001
ARG GROUP_ID=1001

# install required packages
RUN apt-get update --fix-missing \
    && apt-get install -y \
    sudo \
    python3-pip \
    wget \
    bzip2 \
    ca-certificates \
    curl \
    screen \
    tmux \
    file \
    git \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# disable password for sudo commands
RUN echo '%sudo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# install R addons
RUN apt-get update --fix-missing \
    && apt-get install -y \
        libapparmor1 \
        libgc1c2 \
        libclang-dev \
        libcurl4-openssl-dev \
        libedit2 \
        libobjc4 \
        libssl-dev \
        libpq5 \
        lsb-release \
        psmisc \
        procps \
        python-setuptools \
        pwgen \
        libcairo2-dev \
        libgit2-dev \
        default-libmysqlclient-dev \
        libpq-dev \
        libsasl2-dev \
        libsqlite3-dev \
        libssh2-1-dev \
        libxtst6 \
        libcurl4-openssl-dev \
        unixodbc-dev \
        libglpk-dev \
        libxml2-dev \
        libxt6 \
        pandoc \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    # install core R packages
    && install2.r renv
    # # install radian R console
    # && pip3 install radian

# install miniconda for all users to /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh \
    && /bin/bash ~/miniconda.sh -b -p /opt/conda \
    && rm ~/miniconda.sh \
    && /opt/conda/bin/conda clean -tipsy \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    # set permissions with new group for conda users
    && addgroup conda \
    && chgrp -R conda /opt/conda \
    && chmod 770 -R /opt/conda

# add user 
RUN addgroup --gid $GROUP_ID $USERNAME \
    && adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID $USERNAME \
    && usermod -aG sudo,staff,conda $USERNAME

# switch to user
USER $USERNAME
WORKDIR /home/$USERNAME
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 

COPY config .

# remove sudo message from prompt
RUN touch .sudo_as_admin_successful

# configure conda
RUN /opt/conda/bin/conda update -y -n base -c defaults conda \
    && /opt/conda/bin/conda init \
    && /opt/conda/bin/conda config --add channels conda-forge \
    # configure base conda environment
    && /opt/conda/bin/conda env update -f base.yml \
    # cleanup 
    && rm *.yml

CMD [ "/bin/bash" ]
