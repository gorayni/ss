ARG IMG_TAG=tensorflow/tensorflow:1.5.0-gpu-py3

FROM $IMG_TAG

RUN apt-get update
RUN apt-get install -y cowsay \
                       jq

RUN ln -s /usr/games/cowsay /usr/bin/cowsay

RUN pip install --upgrade addict \
                          pip \
				          telegram-send				

# Define environment variables
ENV TF_CPP_MIN_LOG_LEVEL 2
