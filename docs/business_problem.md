# Problema de Negócio

## Contexto

Empresas SaaS (Software as a Service) operam com modelo de receita recorrente baseado em assinaturas. A saúde financeira do negócio depende diretamente de duas variáveis: crescimento de receita e retenção de clientes.

Sem monitoramento adequado, a empresa opera no escuro — incapaz de identificar riscos, oportunidades ou tendências antes que se tornem problemas críticos.

## Perguntas de Negócio

**Receita**

- Quanto de receita recorrente estamos gerando este mês?
- Qual o crescimento do MRR nos últimos 6 meses?
- Quais planos geram mais receita?

**Retenção**

- Qual é o nosso churn rate atual?
- Quais clientes têm maior risco de cancelamento?
- Quanto tempo em média um cliente permanece ativo?

**Produto**

- Quais funcionalidades são mais utilizadas?
- Quais clientes estão com baixo engajamento?
- Qual a frequência média de login por plano?

**Suporte**

- O volume de tickets influencia no churn?
- Qual o tempo médio de resolução por prioridade?
- Quais clientes abrem mais tickets?

**Financeiro**

- Qual o impacto financeiro dos upgrades e downgrades?
- Qual o volume de falhas de pagamento?
- Qual a receita perdida por cancelamentos?

## Solução

Plataforma de banco de dados com arquitetura híbrida — PostgreSQL para dados transacionais e relacionais, MongoDB para eventos e logs comportamentais — capaz de responder todas as perguntas acima em tempo real através de views, functions e métricas consolidadas.
