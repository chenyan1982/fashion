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
ENV APP_DIR /smart-store

# new user
ENV DOCKER_USER=inlay

# Password for the root
ENV ROOT_USER_PASSWORD=root

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

COPY ./smart-store/package.json ./smart-store/npm-shrinkwrap.json /home/${DOCKER_USER}/${APP_DIR}/
RUN chown -R ${DOCKER_USER}:${DOCKER_USER} /home/${DOCKER_USER}/**

# Set the user id
USER ${DOCKER_USER}

WORKDIR /home/${DOCKER_USER}/${APP_DIR}
RUN npm install

VOLUME /home/${DOCKER_USER}/${APP_DIR}/node_modules

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"

###############################################################################
#                                    End                                      #
###############################################################################
