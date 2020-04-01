# AWS Manager

IAM - Perfils de usuários

## Instalação

É necessário ter o ***jq*** instalado (usuários Linux) para fazer tratamentos das saídas em json.

### Buscando um usuário
#### É necessário passar o profile do awscli e o usuário que se quer buscar, não é preciso informar o nome completo.

```bash
/search_user.sh profile-aws user-name
```

```bash
/search_user.sh homologation ter
```

```bash
./search_user.sh dell-note ter # comando
dell-note # output
terraform # output

```

---
### Removendo um usuário
#### É necessário passar o profile do awscli e o usuário que se quer deletar. O script vai listar os grupos, permissões e tokens desse usuário,caso existam. O script vai perguntar se realmente desejar remover o usuário.

```bash
/delete_user.sh profile-aws user-name
```

```bash
/delete_user.sh dell-note rick.sanchez
-------------------------------------------------------------
Groups from user rick.sanchez:
personal
-------------------------------------------------------------
Access Key from user rick.sanchez:
AKIATGMRE2HVA4CCVIES
AKIATGMRE2HVAQMYNT2K
-------------------------------------------------------------
Attached Policies from user rick.sanchez:
arn:aws:iam::aws:policy/AlexaForBusinessFullAccess
arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess
-------------------------------------------------------------
Delete user - rick.sanchez ? [ Yes(Y) or No(N) ]Y
```

#### Depois de confirmar com o ***Y*** o usuário será deletado.

```bash
Delete user - rick.sanchez ? [ Yes(Y) or No(N) ]Y
User rick.sanchez removed from group personal
User rick.sanchez deleted key ID AKIATGMRE2HVA4CCVIES
User rick.sanchez deleted key ID AKIATGMRE2HVAQMYNT2K
Policie removed from user rick.sanchez
Policie removed from user rick.sanchez

An error occurred (NoSuchEntity) when calling the DeleteLoginProfile operation: Login Profile for User rick.sanchez cannot be found.
login-profile deleted from user rick.sanchez
User rick.sanchez deleted from AWS Maxmilhas ACCOUNT dell-note
```
