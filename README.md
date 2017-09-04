# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

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

#dosomething

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