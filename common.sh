#!/bin/bash

pip3 install --prefix='~/.local' --editable ./

# package path
code /home/tiger/.local/lib/python3.7/site-packages

# bd
cd /mnt/bd/drc/translation/wmt14ende/

# 杀掉包含134的所有的进程
nvidia-smi | grep python | grep 134 | awk '{print $3}' | xargs kill -9

# 杀掉某个显卡的所有进程
fuser -v /dev/nvidia2 |awk '{for(i=1;i<=NF;i++)print "kill -9 " $i;}' | sh

# 代理
export http_proxy=http://bj-rd-proxy.byted.org:3128 
export https_proxy=http://bj-rd-proxy.byted.org:3128

# hdfs path
hdfs://haruna/home/byte_arnold_lq_mlnlc/user/duanrenchong

# shell
# https://code.byted.org/lab/dmpjobs/blob/master/dmpjobs/modeltrain/run.sh

until [[ -z "$1" ]]
do
    case $1 in
        --pretrain-model)
            shift; pretrain_model=$1;
            shift;;
        *)
            shift;;
    esac
done

if [[ ${pretrain_model}==checkpoint.pt ]]; then
    pretrain_model="checkpoint.pt"
fi

if [[ ! ${pretrain_model} ]]; then
    pretrain_model="checkpoint.pt"
else
    echo $pretrain_model
fi
