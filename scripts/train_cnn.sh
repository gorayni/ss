#!/bin/bash

export conf_file="$1"

if test "$#" -eq 2; then
   export gpu_number="$2"
else
   export gpu_number=0
fi

export project_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/.. >/dev/null && pwd )"

source $project_dir/scripts/common.sh

#Parsing JSON configuration file
network=`cat "$conf_file" | jq .model.network | tr -d '"'`
learning_rate=`cat "$conf_file" | jq .training.learning_rate`
num_epochs=`cat "$conf_file" | jq .training.num_epochs`

export CUDA_VISIBLE_DEVICES=$gpu_number
export PYTHONPATH="$project_dir" 

cd "$project_dir"

log_fname=$network"_CNN_"`timestamp`.log 

msg1="Training $network for $num_epochs with learning rate $learning_rate in "`hostname`" started"
msg2="Training $network for $num_epochs with learning rate $learning_rate in "`hostname`" finished"

python train_cnn.py "$conf_file" </dev/null 2>&1 | tee "$log_fname" &
msg_me "$!" "$msg1" "$msg2"
