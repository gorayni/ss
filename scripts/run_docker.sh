#!/bin/bash

# Parsing arguments
if test "$#" -lt 1; then
   export gpu_number=0
else
  export gpu_number="$1"
fi

export docker_image="ss_gpu:1.0"
if test "$#" -eq 2; then
  if [ "$2" = "cpu" ]; then
    export docker_image="ss_cpu:1.0"
  fi  
fi

echo Running Docker image "$docker_image" with in GPU "$gpu_number$"

# Creating Docker hostname
docker_hostname="training"
if [[ -n "${TMUX+set}" ]]; then
  tmux_session_name=`tmux display-message -p '#S' | tr ' ' '_'`
  docker_hostname=$tmux_session_name"."$docker_hostname
fi
export docker_hostname=`hostname`"."$docker_hostname

# Obtaining current directory full path
export project_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. >/dev/null && pwd )"
export project_name=`basename -- $project_dir`

docker run --runtime=nvidia --rm -it \
  -h $docker_hostname \
  -e USERID=$UID \
  -e NVIDIA_VISIBLE_DEVICES=$gpu_number \
  --entrypoint /bin/bash \
  -v $project_dir:/root/$project_name \
  -v $project_dir/.bash_history:/root/.bash_history \
  -v $project_dir/telegram-send.conf:/root/.config/telegram-send.conf \
  -w /root/$project_name \
  $docker_image
