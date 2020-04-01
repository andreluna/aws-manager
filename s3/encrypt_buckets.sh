#!/bin/bash

PROFILE="production" # nome do perfil que foi criado
BUCKETS_LIST="/tmp/buckets.txt" # local onde a lista de buckets vai ser salva

function create_bucket_list() {
  aws --profile $PROFILE s3 ls | cut -d " " -f3 > $BUCKETS_LIST
}

function encryption_buckets() {
  while IFS= read -r line
    do
      aws --profile $PROFILE s3api put-bucket-encryption \
      --bucket $line \
          --server-side-encryption-configuration '{"Rules": [{"ApplyServerSideEncryptionByDefault": {"SSEAlgorithm": "AES256"}}]}'
    done < "$BUCKETS_LIST"
}

function decryption_buckets() {
  while IFS= read -r line
    do
      aws --profile $PROFILE s3api delete-bucket-encryption \
          --bucket $line
    done < "$BUCKETS_LIST"
}

function list_buckets_encryption() {
  while IFS= read -r line
    do
      echo "bucket name = $line"
      aws --profile $PROFILE s3api get-bucket-encryption \
          --bucket $line
      echo "-------------------------------------------------------------------"
    done < "$BUCKETS_LIST"
}

#create_bucket_list # funcao para gerar a lista de buckets
#encryption_buckets # funcao para encriptar os buckets listados
#decryption_buckets # funcao para decriptar os buckets listados
list_buckets_encryption # funcao para listar os buckets encriptados
