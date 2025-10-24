## Cyberpunk System Monitor 🖥️⚡

### Coming soon: For normal linux, not git bash...

A beautiful, cyberpunk-themed system monitor for Windows with ASCII art and neon colors.
Features

    🎮 Cyberpunk ASCII Art - Vibrant neon aesthetic with borders

    📊 Real-time Monitoring - CPU, RAM, and GPU usage

    🚀 Optimized Performance - Single PowerShell instance for queries

    🎯 Clean Display - 79x23 perfect terminal dimensions

    🔥 NVIDIA GPU Support - Automatic GPU temperature and usage monitoring

Requirements

    Windows with PowerShell

    Git Bash or WSL for bash shell

    NVIDIA GPU (optional, for GPU stats)

Installation

    Clone the repository:

bash

git clone <your-repo-url>
cd cyberpunk-monitor

    Make the script executable:

bash

chmod +x cyberpunk_monitor.sh

Usage

Run with default 10-second interval:
bash

./cyberpunk_monitor.sh

Run with custom interval (in seconds):
bash

./cyberpunk_monitor.sh 5

Controls

    Ctrl+C - Exit the monitor

What's Monitored

    CPU: Current load percentage

    RAM: Memory usage percentage

    GPU: Usage percentage and temperature (NVIDIA only)

Technical Details

    Uses WMI queries via PowerShell for system data

    Single PowerShell instance per update (not persistent)

    Efficient background updates while maintaining display

    Clean process lifecycle - no memory leaks

Compatibility

    ✅ Windows 10/11

    ✅ Git Bash, WSL, Cygwin

    ✅ NVIDIA GPUs (with nvidia-smi)

    ⚠️ Other GPU brands will show "N/A"

Screenshot
text

```
╔══════════════════════════════════════════════════════════════════════════════╗
║    ██████  ███████  ██████   ███████                                         ║
║   ██       ██   ██  ██   ██  ██                                              ║
║   ██       ██   ██  ██████   █████                                           ║
║   ██       ██   ██  ██   ██  ██                                              ║
║    ██████  ███████  ██   ██  ███████                                         ║
║                                                                              ║
║   [CPU]   ≫≫≫ 45.2% ≪≪≪                                  
║   [RAM]   ≫≫≫ 67.8% ≪≪≪                                  
║   [GPU]   ≫≫≫ 32% | 65C ≪≪≪                                  
║                                                                              ║
║   ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓         ║
║        SYSTEM STATUS: OPERATIONAL | MODE: REAL-TIME | GRID: ONLINE           ║
╚══════════════════════════════════════════════════════════════════════════════╝
```
License

MIT License - Feel free to modify and distribute!
