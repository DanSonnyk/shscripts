#by Daniel Simião https://github.com/DanSonnyk
#Script to calculate average of cpu and memory usage

# Intervalo de amostragem em segundos
interval=2

# Número de amostras
samples=6

# Inicio
startTime=$(date +'%Y-%m-%d %H:%M:S')

echo "Calculando media memoria e cpu ..."
interval_in_hours=$(echo "scale=2; ($samples * $interval) / 3600" | bc)
echo "Intervalo de tempo (em Horas) : $interval_in_hours"

# Variáveis para armazenar a soma dos usos de memória e CPU
total_mem=0
total_cpu=0

# Função para pegar o uso de CPU
get_cpu_usage() {
    # Usando top para pegar o uso de CPU (user + system)
        cpu=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
            echo $cpu
            }

            # Loop para coletar as amostras
            for (( i=0; i<$samples; i++ ))
            do
                # Pega a memória usada (em MB)
                    mem_used=$(free -m | awk 'NR==2{print $3}')

                            # Pega o uso de CPU
                                cpu_used=$(get_cpu_usage)

                                        # Soma a memória usada e o uso de CPU
                                            total_mem=$((total_mem + mem_used))
                                                total_cpu=$(echo "$total_cpu + $cpu_used" | bc)

                                                        # Aguarda o intervalo especificado
                                                            sleep $interval
                                                            done

                                                            clear
                                                            # Calcula a média
                                                            average_mem=$((total_mem / samples))
                                                            average_cpu=$(echo "scale=2; $total_cpu / $samples" | bc)

                                                            endTime=$(date +'%Y-%m-%d %H:%M:S')
                                                            echo "--Entre: $startTime e $endTime --"
                                                            echo "Média de uso de memória (em MB): $average_mem"
                                                            echo "Média de uso de CPU (em %): $average_cpu"