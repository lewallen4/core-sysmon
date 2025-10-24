#!/bin/bash

# Cyberpunk Windows System Monitor - ASCII MAGIC EDITION
# Colors - Neon cyberpunk palette
RED='\033[0;31m'
BRIGHT_RED='\033[1;31m'
GREEN='\033[0;32m'
BRIGHT_GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BRIGHT_BLUE='\033[1;34m'
PURPLE='\033[0;35m'
MAGENTA='\033[1;35m'
CYAN='\033[0;36m'
BRIGHT_CYAN='\033[1;36m'
NC='\033[0m'

# Cache PowerShell instances for faster execution
PS_CPU="Get-WmiObject -Class Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average"
PS_RAM="\$mem = Get-WmiObject -Class Win32_OperatingSystem; \$total = [math]::Round(\$mem.TotalVisibleMemorySize / 1MB, 2); \$free = [math]::Round(\$mem.FreePhysicalMemory / 1MB, 2); \$used = \$total - \$free; \$percent = (\$used / \$total) * 100; Write-Output (\"\$([math]::Round(\$percent, 1))%\")"

# Use a single PowerShell instance for both CPU and RAM
get_system_usage() {
    local result
    result=$(powershell -Command "$PS_CPU; $PS_RAM" 2>/dev/null)
    CPU_USAGE=$(echo "$result" | sed -n '1p')
    RAM_USAGE=$(echo "$result" | sed -n '2p')
}

get_gpu_usage() {
    if command -v nvidia-smi &> /dev/null; then
        # Single nvidia-smi call for both usage and temp
        local gpu_info
        gpu_info=$(nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,noheader,nounits | head -1)
        usage=$(echo "$gpu_info" | awk -F', ' '{print $1}')
        temp=$(echo "$gpu_info" | awk -F', ' '{print $2}')
        echo "${usage}% | ${temp}C"
    else
        echo "N/A"
    fi
}

display_metrics() {
    clear
    echo -e "${BRIGHT_CYAN}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_CYAN}║${NC}${MAGENTA}    ██████  ███████  ██████   ███████                                         ${NC}${BRIGHT_CYAN}║${NC}"
    echo -e "${BRIGHT_CYAN}║${NC}${MAGENTA}   ██       ██   ██  ██   ██  ██                                              ${NC}${BRIGHT_CYAN}║${NC}"
    echo -e "${BRIGHT_CYAN}║${NC}${MAGENTA}   ██       ██   ██  ██████   █████                                           ${NC}${BRIGHT_CYAN}║${NC}"
    echo -e "${BRIGHT_CYAN}║${NC}${MAGENTA}   ██       ██   ██  ██   ██  ██                                              ${NC}${BRIGHT_CYAN}║${NC}"
    echo -e "${BRIGHT_CYAN}║${NC}${MAGENTA}    ██████  ███████  ██   ██  ███████                                         ${NC}${BRIGHT_CYAN}║${NC}"
    echo -e "${BRIGHT_CYAN}║                                                                              ║${NC}"
    echo -e "${BRIGHT_CYAN}║${NC}${BRIGHT_GREEN}   [CPU]${NC}${YELLOW}   ≫≫≫${NC} ${CPU_USAGE}%${NC}${YELLOW} ≪≪≪${NC}                                  ${BRIGHT_CYAN} ${NC}"
    echo -e "${BRIGHT_CYAN}║${NC}${BRIGHT_GREEN}   [RAM]${NC}${YELLOW}   ≫≫≫${NC} ${RAM_USAGE}${NC}${YELLOW} ≪≪≪${NC}                                  ${BRIGHT_CYAN} ${NC}"
    echo -e "${BRIGHT_CYAN}║${NC}${BRIGHT_GREEN}   [GPU]${NC}${YELLOW}   ≫≫≫${NC} $(get_gpu_usage)${NC}${YELLOW} ≪≪≪${NC}                                  ${BRIGHT_CYAN} ${NC}"
    echo -e "${BRIGHT_CYAN}║                                                                              ║${NC}"
    echo -e "${BRIGHT_CYAN}║${NC}${BRIGHT_RED}   ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓   ${NC}${BRIGHT_CYAN}      ║${NC}"
    echo -e "${BRIGHT_CYAN}║${NC}${CYAN}        SYSTEM STATUS: ${BRIGHT_GREEN}OPERATIONAL${NC}${CYAN} | MODE: ${BRIGHT_GREEN}REAL-TIME${NC}${CYAN} | GRID: ${BRIGHT_GREEN}ONLINE${NC}         ${BRIGHT_CYAN}  ║${NC}"
    echo -e "${BRIGHT_CYAN}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${YELLOW}   Press Q and RETURN to exit after the loop${NC}"
}

# Main loop
interval=${1:-10}

# Pre-load values
CPU_USAGE="Loading..."
RAM_USAGE="Loading..."
get_system_usage

while true; do
    # Get fresh system usage (CPU and RAM together)
    get_system_usage &
    SYSTEM_PID=$!
    
    # Display immediately with potentially cached values
    display_metrics
    
    # Check for 'q' key press with short timeout
    read -r -t 0.5 -n1 key && [[ $key == "q" ]] && break
    
    # Wait for the background update to complete
    wait $SYSTEM_PID 2>/dev/null
    
    sleep $interval
done

echo -e "\n${BRIGHT_RED}Disconnecting from system matrix...${NC}"
sleep 1
clear
