#!/bin/bash
set -euo pipefail
#Цвета для каждой проверки
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

FILE="file$(date +%Y:%m:%d).txt"
LOG_FILE="/home/practise/$FILE"

checker () {
echo "--------------------------------"
echo "Мониторинг системы: $(hostname)"
echo "Время: $(date)"
echo "--------------------------------"

echo "====Проверка памяти===="
  MEM="$(free | awk '/Mem/ {printf("%.1f%\n", $3/$2 * 100)}' | sed 's/..%//')"

if [[ "$MEM" -gt 90 ]]; then
  echo -e "${RED}Critical warning. Память заполена выше 90%${NC}. ${MEM}"
    elif [[ "$MEM" -gt 80 ]]; then
      echo -e "${YELLOW}Warning. Память заполнена выше 80%${NC}. ${MEM}"
        else 
          echo -e "${GREEN}Ok: Ваша память на стабильном уровне${NC} ${MEM}"
fi

echo "--------------------------------"

echo "====Проверка Процессора===="
CPU="$(uptime | awk '{print $8, $9, $NF}')"
CORES=$(grep -c processor /proc/cpuinfo)
    echo "Загрузка: $CPU. Ядер: $CORES"

echo "--------------------------------"

echo "====Проверка дисков===="
DISK="$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')"
    if [[ "$DISK" -gt 90 ]]; then
  echo -e "${RED}Critical warning. Память диска выше 90%${NC}. ${DISK}"
    elif [[ "$DISK" -gt 80 ]]; then
      echo -e "${YELLOW}Warning. Память диска заполнена выше 80%${NC}. ${DISK}"
        else 
         echo -e "${GREEN}Ok. Ваша память диска на стабильном уровне${NC}. ${DISK}"
fi

echo "--------------------------------"

echo "====Проверка состояни сервисов===="
} 
checker | tee -a "$LOG_FILE"
