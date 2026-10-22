#!/bin/bash

# URL base da API
URL="http://localhost:3012/api/v1/veiculos"
LOG_FILE="auditoria_final.log"

# Inicializa o arquivo de log
echo "=== INÍCIO DOS TESTES DA API DE FROTAS ===" > "$LOG_FILE"
echo "" >> "$LOG_FILE"

# 1. Cadastrar o primeiro veículo (ID 3, assumindo que 1 e 2 já existem)
echo "--- 1. Cadastrando o primeiro veículo ---" >> "$LOG_FILE"
curl -s -X POST "$URL" \
  -H "Content-Type: application/json" \
  -d '{
    "placa": "DEF-5678",
    "montadora": "Volvo",
    "modelo": "FH 540"
  }' >> "$LOG_FILE"
echo -e "\n\n" >> "$LOG_FILE"

# 2. Cadastrar o segundo veículo (ID 4)
echo "--- 2. Cadastrando o segundo veículo ---" >> "$LOG_FILE"
curl -s -X POST "$URL" \
  -H "Content-Type: application/json" \
  -d '{
    "placa": "GHI-9012",
    "montadora": "Volkswagen",
    "modelo": "Meteor 28.460"
  }' >> "$LOG_FILE"
echo -e "\n\n" >> "$LOG_FILE"

# 3. Atualizar 1 deles (Atualizando o status do veículo ID 3)
echo "--- 3. Atualizando o status do veículo ID 3 ---" >> "$LOG_FILE"
curl -s -X PATCH "$URL/3/status" \
  -H "Content-Type: application/json" \
  -d '{
    "status": "EM_ROTA"
  }' >> "$LOG_FILE"
echo -e "\n\n" >> "$LOG_FILE"

# 4. Deletar o outro (Removendo o veículo ID 4)
echo "--- 4. Deletando o veículo ID 4 ---" >> "$LOG_FILE"
curl -s -X DELETE "$URL/7" >> "$LOG_FILE"
echo -e "\n\n" >> "$LOG_FILE"

echo "=== FIM DOS TESTES CRUD ===" >> "$LOG_FILE"

echo "Script executado com sucesso! Os logs foram salvos em '$LOG_FILE'."
