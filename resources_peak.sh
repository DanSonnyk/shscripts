#by Daniel Simião https://github.com/DanSonnyk/shscripts.git
#Script to calculate peak of cpu and memory usage

# Intervalo de amostragem em segundos
interval=60

# Número de amostras 
samples=5

# Inicio
startTime=$(date +'%Y-%m-%d %H:%M:%S')

echo "Calculando picos de memória e CPU..."
interval_in_hours=$(echo "scale=2; ($samples * $interval) / 3600" | bc)
echo "Intervalo de tempo (em Horas): $interval_in_hours"

# Variáveis para armazenar os picos de uso de memória e CPU
peak_mem=0
peak_cpu=0

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

    # Verifica se a memória usada é o pico
    if (( mem_used > peak_mem )); then
        peak_mem=$mem_used
    fi

    # Verifica se o uso de CPU é o pico
    if (( $(echo "$cpu_used > $peak_cpu" | bc -l) )); then
        peak_cpu=$cpu_used
    fi

    # Aguarda o intervalo especificado
    sleep $interval
done

endTime=$(date +'%Y-%m-%d %H:%M:%S')
echo "--Entre: $startTime e $endTime --"
echo "Pico de uso de memória (em MB): $peak_mem"
echo "Pico de uso de CPU (em %): $peak_cpu"
