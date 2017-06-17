FROM ruby:2.3.4

# nodejs ppa
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -

# note: apt update and all install commands should be in the same run statement
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    # oracle instant client support
    build-essential libpq-dev libaio1 unzip \
    # nodejs support
    nodejs python python-dev python-pip python-virtualenv && \
    # it is good practice to scrub apt-get cache before commiting this to the image
    rm -rf /var/lib/apt/lists/*

# install oracle instant client
RUN mkdir /opt/oracle
COPY oracle/*.zip /opt/oracle/
RUN cd /opt/oracle && unzip -q \*.zip
RUN cd /opt/oracle/instantclient_12_1 && ln -s libclntsh.so.12.1 libclntsh.so

ENV LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/opt/oracle/instantclient_12_1"
