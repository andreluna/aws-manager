# AWS Manager

S3 - Encriptação e verificação de buckets

## Utilização

É necessário inserir no código o nome do perfil e o local onde a lista de buckets vai ficar.

```bash
PROFILE="production" # nome do perfil que foi criado
BUCKETS_LIST="/tmp/buckets.txt" # local onde a lista de buckets vai ser salva
```

### Para utilização do script, basta comentar/descomentar as funções conforme abaixo.

```bash
#create_bucket_list # funcao para gerar a lista de buckets
#encryption_buckets # funcao para encriptar os buckets listados
#decryption_buckets # funcao para decriptar os buckets listados
list_buckets_encryption # funcao para listar os buckets encriptados
```
