# Bash Aliases

# Safety function for system-modifying commands
confirm_system_update() {
    echo "This command will update system packages. Continue? (y/N)"
    read -r response
    [[ "$response" =~ ^[Yy]$ ]]
}

# Navigation
alias l='cd ~/labor'
alias g='cd ~/labor/gits'
alias d='cd ~/Downloads'
alias t='cd ~/labor/tmp'
alias gd="cd ~/labor/GoogleDrive && [ -z '$(ls -A ~/labor/GoogleDrive)' ] && google-drive-ocamlfuse ~/labor/GoogleDrive"

# Development Tools
alias cursor='~/.AppImage/cursor/*.AppImage --no-sandbox'
alias pc="~/opt/pycharm-2025.2.4/bin/pycharm.sh &"
alias kc="kilocode"
alias pypurge='pip cache purge; mamba clean --all'
alias rlb="set FORCE_MAMBA_INIT=1 && source ~/.bashrc"

# AI/ML Tools
# ShellGPT shortcut
alias ex='sgpt -s'
# Launch ML workspace container with GPU support on port 8080
alias ml="docker run --gpus all --rm -d -p 8080:8080 mltooling/ml-workspace-gpu; deco \# 64; echo -e '# ml-container runnig - launch \e[4;34mhttp://localhost:8080\e[0m or ssh ml #'; deco \# 64"
# Run ComfyUI
alias comfy='python ~/labor/gits/ComfyUI/main.py'
# Activate conda env and run Stable Diffusion WebUI
alias a11='mamba activate a11; ~/labor/gits/stable-diffusion-webui/webui.sh; mamba activate $(test -f ~/.startenv && cat ~/.startenv || echo base)'
# Start Dify in Docker
alias dify='cd  ~/labor/gits/dify/docker; docker compose up -d'
# Use ShellGPT to explain error messages
alias what='sgpt -d "es folgt die fehlerausgabe eines bash kommandos. bitte erkläre was die fehlermeldung bedeutet und wie sie behoben werden kann. hier kommt die meldung: $(cat ~/.lasterror)"'
# Start OpenAI realtime console
alias rtc='npm start --prefix ~/labor/gits/openai-realtime-console'
# Run PySpur in Docker on port 6080
alias spur="cd ~/labor/gits/pyspur; docker compose -f ./docker-compose.prod.yml up --build -d; echo $'\n\e[106m' 'Open PySpur' $'\e[0m' 'on http://localhost:6080/' $'\n'"
# Run Redis stack on ports 6379 and 8001
alias redis="docker run --rm -d --name redis-stack -p 6379:6379 -p 8001:8001 -v $HOME/labor/v_redis:/data redis/redis-stack:latest"
# Launch AnythingLLM desktop app
alias anyllm="~/AnythingLLMDesktop.AppImage"
# Launch LM Studio
alias lmstudio='~/.AppImage/lmstudio/*.AppImage --no-sandbox'
# Start Flowise and open browser
alias flow="npx flowise start && xdg-open http://localhost:3000"
# Run N8N with ngrok tunnel
alias n8="cd $HOME/labor/gits/n8n-ngrok/ && docker compose up -d && echo -e '\n\e[103mN8N runing on\e[0m \e[1;3;34mhttps://special-newly-duckling.ngrok-free.app/home/workflows\e[0;0m\nStop by typing \e[1;3;34mstop\e[0;0m\n'"
# Launch Pinokio
alias pinokio='chmod +x ~/.AppImage/pinokio/*.AppImage && ~/.AppImage/pinokio/*.AppImage --no-sandbox'
# Activate conda env and run Deer Flow
alias deer="mamba activate ds12m && cd ~/labor/gits/deer-flow && ./bootstrap.sh -d"
# Run LibreChat in Docker on port 3080
alias librechat="cd ~/labor/gits/LibreChat && echo -e '\n\e[103mLibreChat runing on\e[0m \e[1;3;34mhttp://localhost:3080/\e[0;0m\nStop by typing \e[1;3;34mstop\e[0;0m\n' && docker compose up -d"
# Activate conda env and run Magnetic UI on port 8081
alias mui="mamba activate mui11 && magentic ui --port 8081 && mamba activate $(test -f ~/.startenv && cat ~/.startenv || echo base)"
# Use Node 22 and run Gemini
alias gem="nvm use 22 && gemini"
# Run Open WebUI with uvx
alias owu="DATA_DIR=~/.open-webui uvx --python 3.11 open-webui@latest serve"

# System Management
# Update system packages with confirmation
alias suu="confirm_system_update && sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt clean && flatpak update -y && sudo snap refresh"
alias los="cw && suu"
alias losj="cw && suu && jl . && stop"
alias losc="cw && suu && chromerdb && stop"
# Stop Docker containers and compose
alias stop='[ -f docker-compose.yaml ] && (echo -e "\n\e[103mDOWN\e[0m" && docker compose down); running_containers=$(docker ps -q); [ -n "$running_containers" ] && (echo -e "\n\e[103mSTOP\e[0m" && docker stop $running_containers); echo ""'
# Launch Chrome with remote debugging on port 9222
alias chromerdb="echo -e '\n\e[103mChrome Remote Debuging runing on\e[0m \e[1;3;34mhttp://localhost:9222/\e[0;0m\nSet data dir to \e[1;3;34m/tmp/chrome-debug\e[0;0m\n' && google-chrome-canary --remote-debugging-port=9222 --user-data-dir=/home/frank/.config/google-chrome-debug"
# Kill Kodi processes
alias kk="pgrep kodi | xargs kill -9"
# Run SearXNG search engine in Docker on port 8088
alias searx='mkdir -p ~/.searxng/config/ ~/.searxng/data/ ; docker stop searxng >/dev/null 2>&1 ; docker rm searxng >/dev/null 2>&1 ; docker run --name searxng -d --restart unless-stopped -p 8088:8080 -v "/home/frank/.searxng/config/:/etc/searxng/" -v "/home/frank/.searxng/data/:/var/cache/searxng/" docker.io/searxng/searxng:latest && echo -e "to stop \x1b[46msearxng on 8088\x1b[0m type stop"'

# SSH Connections
alias doogee="ssh -o IdentitiesOnly=yes -i ~/.ssh/id_doogee -p 8022 u0_a218@doogee"
alias redmi="ssh -o IdentitiesOnly=yes -i ~/.ssh/id_rsa -p 8022 u0_a470@redmi"
alias teci="ssh -p 8022 u0_a218@teci"

# Utilities
alias lsc="ls -d .[^.]*"
