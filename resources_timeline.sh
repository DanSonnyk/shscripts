#!/bin/bash
#by Daniel Simião https://github.com/DanSonnyk/shscripts.git
#Script to collect all samples of cpu and memory usage

# Intervalo de amostragem em segundos
interval=2

# Número de amostras
samples=6

# Inicio
startTime=$(date +'%Y-%m-%d %H:%M:%S')

echo "Coletando amostras de memória e CPU..."
interval_in_hours=$(echo "scale=2; ($samples * $interval) / 3600" | bc)
echo "Intervalo de tempo (em Horas): $interval_in_hours"

# Arrays para armazenar as amostras de uso de memória e CPU
mem_samples=()
cpu_samples=()

# Função para pegar o uso de CPU
get_cpu_usage() {
    # Usando top para pegar o uso de CPU (user + system)
    cpu=$(top -l 1 | grep "CPU usage" | awk '{print $3+$5}')
    echo $cpu
}

# Função para pegar o uso de memória
get_mem_usage() {
    mem_used=$(vm_stat | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
    mem_used=$(($mem_used * 4096 / 1024 / 1024)) # Convertendo para MB
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
    mem_samples+=($mem_used)
    cpu_samples+=($cpu_used)

    # Aguarda o intervalo especificado
    sleep $interval
done

endTime=$(date +'%Y-%m-%d %H:%M:%S')
echo "--Entre: $startTime e $endTime --"
echo "Amostras de uso de memória (em MB): ${mem_samples[@]}"
echo "Amostras de uso de CPU (em %): ${cpu_samples[@]}"