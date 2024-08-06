#!/bin/bash
#by Daniel Simião https://github.com/DanSonnyk/shscripts.git
#Script to collect all samples of cpu and memory usage

# Intervalo de amostragem em segundos
interval=60

# Número de amostras
samples=60

# Nome do arquivo CSV
output_file="result_resourses.csv"

# Inicio
startTime=$(date +'%Y-%m-%d %H:%M:%S')

echo "Coletando amostras de memória e CPU..."
interval_in_hours=$(echo "scale=2; ($samples/60)" | bc)
echo "Intervalo de tempo (em Horas): $interval_in_hours"

# Arrays para armazenar as amostras de uso de memória e CPU
samplesList=()

# Função para pegar o uso de CPU
get_cpu_usage() {
    # Usando top para pegar o uso de CPU (user + system)
    cpu=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo $cpu
}

# Função para pegar o uso de memória
get_mem_usage() {
    mem_used=$(free -m | grep "Mem:" | awk '{print $3}')
    echo $mem_used
}

# Loop para coletar as amostras
for (( i=0; i<$samples; i++ ))
do
    # Pega a memória usada
    mem_used=$(get_mem_usage)

    # Pega o uso de CPU
    cpu_used=$(get_cpu_usage)

    # Armazena as amostras nos arrays
    samplesList+=("$cpu_used , $mem_used")
    echo $cpu_used "|" $mem_used >> $output_file
    # Aguarda o intervalo especificado
    sleep $interval
done

endTime=$(date +'%Y-%m-%d %H:%M:%S')
echo "--Entre: $startTime e $endTime --"
echo "Amostras de uso de memória (em MB) e CPU (em %): "
echo "CPU % | Memoria (MB)"
for item in "${samplesList[@]}"; do
  printf "%s\n\n" "$item"
done
