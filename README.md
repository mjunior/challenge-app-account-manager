
# Necessidade a ser resolvida: Sistema para controle de contas
Você deve criar um CRUD para manutenção de Contas de saldo. Podemos ter 2 tipos de contas:

**Conta Matriz** – É a conta principal, a qual pode ter (n) contas filhas e essas também podem possuir suas filhas, formando assim uma hierarquia. É a principal conta da estrutura.


**Contas Filiais** – É uma conta idêntica a Conta Matriz, porém possui obrigatoriamente uma conta Pai (pode ser a Conta Matriz ou outra Conta Filial) e pode ou não ter uma Conta Filial abaixo.

**Dados para o Cadastro de Contas**
- Nome
- Data de Criação

_Obs: Toda Conta deve possuir uma Pessoa e esta pode ser Jurídica ou Física_

**Dados para Pessoa Jurídica**
- CNPJ
- Razão Social
- Nome Fantasia

**Dados para Pessoa Física**
- CPF
- Nome Completo
- Data Nascimento

**Funcionalidade de Transferência**

Toda Conta Filial pode efetuar transferências desde que a conta que receberá a transferência esteja debaixo da mesma árvore e não seja uma conta Matriz.

A Conta Matriz não pode receber transferências de outras contas, apenas Aportes que devem possuir um código alfanumérico único.

Toda transação pode ser estornada (no caso de um estorno de um Aporte é necessário informar o código alfanumérico para que a transação possa ser estornada).
Apenas as Contas Ativas podem receber Aportes ou Transferências

**Situação da Conta**
- Toda Conta pode estar ativa, bloqueada ou cancelada;
- Todo Histórico de transações deve ser armazenado e consultado.

**Glossário de termos**
Aporte - Entrada de valores diretamente na Conta Matriz, através de uma transação qualquer.
Transferência – Valores movimentados entre contas, onde uma é debitada e a outra é creditada.



## Ambiente de Desenvolvimento
* [Instale Virtual Box](http://www.virtualbox.org/wiki/Downloads)
* [Instale Vagrant](https://www.vagrantup.com/)
* Clone este repositorio
* Acesse a pasta e suba a máquina com o comando `vagrant up`
* Acesse a máquina virtual com o comando `vagrant ssh`
* Na máquina virtual acesse a pasta do projeto `cd /vagrant`
* Rode os comandos para configuração do ambiente Rails.

 `bundle install`

`rake db:create db:migrate db:seed`
* Suba o servidor rails rodando o comando  `rails s -b 0.0.0.0`
* O Projeto estara disponivel em `http://localhost:3300`



## Configuraçes do ambiente

* Ruby version: 2.4.0

* Rails version: 5.0.5

* Banco de dados: MySQL

# Documentação da API

# API Pessoas

### Listando todas as pessoas cadastradas.
#GET /api/people

```
[   {
      "id": 2,
      "name": "Mjunior",
      "document": "10103711251571",
      "type": "Pessoa jurídica"
    },
    {
      "id": 1,
      "name": "Maurício Júnior",
      "document": "120.639.636-90",
      "type": "Pessoa física"
    }
]
```
### Listando informações de uma pessoa
#GET /api/people/:id

```
{
  "id": 1,
  "full_name": "Maurício Júnior",
  "cnpj": null,
  "company_name": null,
  "trade_name": null,
  "cpf": "12063963690",
  "birthdate": "2017-08-31T23:54:38.000-03:00",
  "created_at": "2017-08-31T23:54:38.000-03:00",
  "updated_at": "2017-08-31T23:54:38.000-03:00",
  "status": "active"
}
```
### Cadastrando um novo usuário
#POST /api/people


* Cadastrando uma pessoa física. Envie os dados abaixo com `type: NaturalPerson`
```
  {
    "full_name": "Mauricio Junior", 
    "cpf": "12065963520", 
    "birthdate": "25/01/1995",
    "type": "NaturalPerson"
  }
```

* Cadastrando uma pessoa jurídica. Envie os dados abaixo com `type: LegalPerson`
```
  {
    "company_name": "MJUNIOR",
    "trade_name": "MJR", 
    "cnpj": "44.322.122/000305",
    "type": "LegalPerson"
  }
```

### Atualizar dados de um usuário
#PATCH/PUT /api/people/:id

```
  {
    "company_name": "MJUNIOR"
  }
```

### Excluir um usuário

#DELETE /api/people/:id
* Nenhum dado é retornado, Aguarde um HTTP STATUS 204

# API Contas

### Listando todas as contas

#GET /api/accounts

```
[
  {
    "id": 9,
    "name": "MJUNIOR 1000",
    "parent_id": null,
    "creation_date": null,
    "created_at": "2017-09-04T02:02:53.000-03:00",
    "updated_at": "2017-09-04T02:02:53.000-03:00",
    "person_id": 16,
    "status": "active"
  },
  {
    "id": 8,
    "name": "abc123",
    "parent_id": 5,
    "creation_date": null,
    "created_at": "2017-09-03T21:34:49.000-03:00",
    "updated_at": "2017-09-03T21:34:49.000-03:00",
    "person_id": 1,
    "status": "active"
  }]
```

### Listando dados de uma conta

#GET /api/accounts/:id
* `account` Informações da conta
* `transaction_input[]` Todas as transações onde a conta foi o DESTINO. Entradas de valores.
* `transaction_output[]` Todas as transações onde a conta foi a ORIGEM. Saida de valores. 

_#TODO: Listar filiais e informações da Matriz_
```
{
  "account": {
    "id": 3,
    "name": "100.2",
    "parent_id": 1,
    "creation_date": null,
    "created_at": "2017-08-31T23:54:38.000-03:00",
    "updated_at": "2017-08-31T23:54:38.000-03:00",
    "person_id": 1,
    "status": "active"
  },
  "transactions_input": [{
    "id": 48,
    "origin_id": 1,
    "destination_id": 3,
    "transaction_type": "reversal",
    "amount": 987,
    "token": null,
    "created_at": "2017-09-03T22:45:02.000-03:00",
    "updated_at": "2017-09-03T22:45:02.000-03:00",
    "status": "completed"
  },{
    "id": 49,
    "origin_id": 1,
    "destination_id": 3,
    "transaction_type": "transfer",
    "amount": 876,
    "token": null,
    "created_at": "2017-09-03T22:48:10.000-03:00",
    "updated_at": "2017-09-04T01:14:42.000-03:00",
    "status": "canceled"
  }],
  "transactions_output": [{
    "id": 47,
    "origin_id": 3,
    "destination_id": 1,
    "transaction_type": "contribution",
    "amount": 987,
    "token": "4adb3e4803a5918b6b45535a",
    "created_at": "2017-09-03T22:42:04.000-03:00",
    "updated_at": "2017-09-03T22:45:02.000-03:00",
    "status": "canceled"
  },
  {
    "id": 51,
    "origin_id": 3,
    "destination_id": 1,
    "transaction_type": "reversal",
    "amount": 113,
    "token": null,
    "created_at": "2017-09-04T01:07:19.000-03:00",
    "updated_at": "2017-09-04T01:07:19.000-03:00",
    "status": "completed"
  }]
}
```

### Cadastrando uma nova conta

* `person_id`: Campo obrigatorio. Toda conta deve ser associada a uma pessoa.

* `parent_id`: Quando se cadastra uma filial é necessário informar uma conta matriz.


#### Para cadastrar uma filial envie `type: 'Branch'`
#POST /api/accounts
```
{
  "name":"MJUNIOR - Filial", 
  "type":"Branch", 
  "person_id":"16",
  "parent_id":"16",
}
```

#### Para cadastrar uma Matriz envie `type: 'Main'`
#POST /api/accounts
```
{
  "name":"MJUNIOR - Matriz", 
  "type":"Main", 
  "person_id":"16",
}
```

### Atualizando informações de uma Cona

#PUT/PATCH /api/accounts/:id

```
{
  "name":"MJUNIOR"
} 
```

### Desativando uma conta
#DELETE /api/account/:id
* Aguarde retorno HTTP STATUS 204 


#  API Transações

#### Lista todas as transações
#GET /api/transactions

```
[
  {
    "id": 1,
    "transaction_type": "transfer",
    "origin": {
      "id": 1,
      "name": "100",
      "parent_id": null,
      "creation_date": null,
      "created_at": "2017-09-01T02:54:38.000Z",
      "updated_at": "2017-09-01T02:54:38.000Z",
      "person_id": 1,
      "status": "active"
    },
    "destination": {
      "id": 2,
      "name": "100.1",
      "parent_id": 1,
      "creation_date": null,
      "created_at": "2017-09-01T02:54:38.000Z",
      "updated_at": "2017-09-01T02:54:38.000Z",
      "person_id": 1,
      "status": "active"
    },
    "amount": 100
},
{
    "id": 2,
    "transaction_type": "transfer",
    "origin": {
      "id": 1,
      "name": "100",
      "parent_id": null,
      "creation_date": null,
      "created_at": "2017-09-01T02:54:38.000Z",
      "updated_at": "2017-09-01T02:54:38.000Z",
      "person_id": 1,
      "status": "active"
    },
    "destination": {
      "id": 2,
      "name": "100.1",
      "parent_id": 1,
      "creation_date": null,
      "created_at": "2017-09-01T02:54:38.000Z",
      "updated_at": "2017-09-01T02:54:38.000Z",
      "person_id": 1,
      "status": "active"
    },
    "amount": 100
},
{
    "id": 3,
    "transaction_type": "transfer",
    "origin": {
      "id": 1,
      "name": "100",
      "parent_id": null,
      "creation_date": null,
      "created_at": "2017-09-01T02:54:38.000Z",
      "updated_at": "2017-09-01T02:54:38.000Z",
      "person_id": 1,
      "status": "active"
    },
    "destination": {
      "id": 2,
      "name": "100.1",
      "parent_id": 1,
      "creation_date": null,
      "created_at": "2017-09-01T02:54:38.000Z",
      "updated_at": "2017-09-01T02:54:38.000Z",
      "person_id": 1,
      "status": "active"
    },
    "amount": 100
  }
]
```
#### Cria uma nova transação
#POST api/transactions

* `transaction_type` - Tipo da transação - `'transfer' | 'contribution'`
* `origin_id` - Conta onde o valor será creditada.
* `destination_id` - Conta onde o valor sera debitada.
* `amount` - Valor da transação

```
{
  "transaction_type": "contribution",
  "origin_id": "1",
  "destination_id": "1",
  "amount": "100"
}
```

### Estornando uma transação
#POST api/transactions/:transaction_id/reversal

* Para estornar uma transação do tipo `contribution` é necessário informar o token da transação. Para transações do tipo `transfer` não envie este campo ou passe como string vazia `""`

```
{
  "transaction_token": "30bedbc47a7536c4ad60ee75",
}
```
