#!/usr/bin/env bash
set -ex

git clone https://github.com/bytedance/lightseq.git --recursive
cd lightseq
git switch rc_quant_exp
pip3 install -e ./

if [ ! -d "/tmp/wmt14_en_de" ]; then
    echo "Downloading dataset"
    wget http://lf3-nlp-opensource.bytetos.com/obj/nlp-opensource/lightseq/wmt_data/databin_wmt14_en_de.tar.gz -P /tmp
    tar -zxvf /tmp/databin_wmt14_en_de.tar.gz -C /tmp && rm /tmp/databin_wmt14_en_de.tar.gz
fi

lightseq-train /tmp/wmt14_en_de/ \
    --task translation \
    --arch ls_transformer --share-decoder-input-output-embed \
    --optimizer ls_adam --adam-betas '(0.9, 0.98)' \
    --clip-norm 0.0 \
    --lr 5e-4 --lr-scheduler inverse_sqrt --warmup-updates 4000 --weight-decay 0.0001 \
    --criterion ls_label_smoothed_cross_entropy --label-smoothing 0.1 \
    --max-tokens 8192 \
    --eval-bleu \
    --eval-bleu-args '{"beam": 5, "max_len_a": 1.2, "max_len_b": 10}' \
    --eval-bleu-detok moses \
    --eval-bleu-remove-bpe \
    --eval-bleu-print-samples \
    --best-checkpoint-metric bleu \
    --maximize-best-checkpoint-metric \
    --keep-last-epochs 5 --max-epoch 90 \
    --fp16 \
    --use-torch-layer \
    --enable-quant \
    --quant-mode qat --grad-factor $1
    
CUDA_VISIBLE_DEVICES=0 lightseq-generate /tmp/wmt14_en_de  \
        --path checkpoints/checkpoint_best.pt \
        --beam 4 --batch-size 128 --remove-bpe --lenpen 0.6 --fp16 --quiet

