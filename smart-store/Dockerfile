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
        adduser

# Set the root password
RUN echo "root:${ROOT_USER_PASSWORD}" | chpasswd

# Create new user
RUN useradd --user-group --create-home --shell /bin/false ${DOCKER_USER}

COPY ./smart-store /home/${DOCKER_USER}/${APP_DIR}/

RUN rm -f package.json npm-shrinkwrap.json

RUN chown -R ${DOCKER_USER}:${DOCKER_USER} /home/${DOCKER_USER}/*

# Set the user id
USER ${DOCKER_USER}

WORKDIR /home/${DOCKER_USER}/${APP_DIR}

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"

###############################################################################
#                                    End                                      #
###############################################################################
