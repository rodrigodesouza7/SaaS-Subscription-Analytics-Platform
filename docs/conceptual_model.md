# Modelo Conceitual

## Entidades e Relacionamentos

### Entidades Principais

**CUSTOMER** (Cliente)

- Representa uma empresa contratante do SaaS
- Possui uma ou mais assinaturas
- Pode abrir tickets de suporte
- Gera eventos de uso do produto

**PLAN** (Plano)

- Define o nível de serviço contratado
- Starter, Professional, Business, Enterprise
- Possui preço mensal e anual

**SUBSCRIPTION** (Assinatura)

- Vínculo entre cliente e plano
- Possui ciclo de vida: active → canceled / suspended
- Gera faturas mensalmente

**INVOICE** (Fatura)

- Gerada mensalmente por assinatura
- Pode estar paga, pendente ou em atraso
- Vinculada a um ou mais pagamentos

**PAYMENT** (Pagamento)

- Registro de pagamento de uma fatura
- Métodos: Credit Card, PIX, Bank Transfer, Boleto

**SUPPORT TICKET** (Ticket de Suporte)

- Aberto por um cliente
- Possui prioridade: Low, Medium, High, Critical
- Status: Open, In Progress, Closed

---

## Relacionamentos

| Entidade A   | Cardinalidade | Entidade B     |
| ------------ | ------------- | -------------- |
| CUSTOMER     | 1 : N         | SUBSCRIPTION   |
| PLAN         | 1 : N         | SUBSCRIPTION   |
| SUBSCRIPTION | 1 : N         | INVOICE        |
| INVOICE      | 1 : N         | PAYMENT        |
| CUSTOMER     | 1 : N         | SUPPORT TICKET |

---

## Eventos (MongoDB)

**USER EVENTS**

- Eventos de uso de funcionalidades por cliente

**LOGIN EVENTS**

- Registro de logins por device e localização

**AUDIT LOGS**

- Registro de todas as operações críticas no sistema

---

## Fluxo Principal

```
CUSTOMER
    └── contrata → SUBSCRIPTION
                        └── vinculada a → PLAN
                        └── gera → INVOICE
                                      └── paga via → PAYMENT
    └── abre → SUPPORT TICKET
    └── gera → USER EVENTS (MongoDB)
    └── gera → LOGIN EVENTS (MongoDB)
```
