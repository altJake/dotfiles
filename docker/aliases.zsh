alias d='docker'
alias dc='docker compose'       # modern syntax (replaces docker-compose)
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dlog='docker logs -f'     # follow logs
alias dex='docker exec -it'     # exec into container interactively
alias dstop='docker stop $(docker ps -q)'  # stop all running containers

# Colima (Docker VM)
alias col='colima start'
alias colstop='colima stop'
alias colst='colima status'
