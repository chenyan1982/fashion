###############################################################################
#                           Header Documentation                              #
###############################################################################


###############################################################################
#                                   Header                                    #
###############################################################################
FROM ubuntu-upstart
MAINTAINER Calvin.Chen

###############################################################################
#                            Environment Variables                            #
###############################################################################
# app directory
ENV APP_DIR /fashion

# new user
ENV DOCKER_USER=inlay

# Password for the root
ENV ROOT_USER_PASSWORD=root

# service port
ENV APP_PORT 3000

###############################################################################
#                                Instructions                                 #
###############################################################################
# Install dependencies
RUN apt-get update -yq \
	&& apt-get upgrade -yq

RUN apt-get install -yq --no-install-recommends \
        gcc \
        g++ \
        make \
        python \
        adduser \
				git \
				wget

# Download node source package and install
RUN wget https://nodejs.org/download/release/v5.9.1/node-v5.9.1.tar.gz

RUN tar zxvf node-v5.9.1.tar.gz \
	&& rm -f node-v5.9.1.tar.gz

WORKDIR node-v5.9.1/

RUN ./configure \
	&& make install


# Set the root password
RUN echo "root:${ROOT_USER_PASSWORD}" | chpasswd

# Create new user
RUN useradd --user-group --create-home --shell /bin/false ${DOCKER_USER}

# Set the user id
USER ${DOCKER_USER}

WORKDIR /home/${DOCKER_USER}/${APP_DIR}

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"

###############################################################################
#                                    End                                      #
###############################################################################
