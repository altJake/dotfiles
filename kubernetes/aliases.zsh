# Context / namespace
alias kcx="kubectx"
alias kns="kubens"
alias kcuc='kubectl config use-context'
alias kcgc='kubectl config get-contexts'
alias kcdc='kubectl config delete-context'

# Core
alias k='kubectl'
alias kaf='kubectl apply -f'
alias kdel='kubectl delete'
alias kdelf='kubectl delete -f'
alias kcp='kubectl cp'
alias krun='kubectl run'
alias kga='kubectl get all'
alias kpf='kubectl port-forward'

# Pods
alias kgp='kubectl get pods'
alias kgpw='kubectl get pods --watch'
alias kgpa='kubectl get pods --all-namespaces'
alias kgpwide='kubectl get pods -o wide'
alias kgpl='kubectl get pods -l'
alias kdp='kubectl describe pod'
alias wkp='watch -n 1 kubectl get pods'

# Deployments
alias kgd='kubectl get deployment'
alias kgdw='kubectl get deployment --watch'
alias kgda='kubectl get deployment --all-namespaces'
alias kgdwide='kubectl get deployment -o wide'
alias kdd='kubectl describe deployment'

# Services
alias kgs='kubectl get service'
alias kgsw='kubectl get service --watch'
alias kgsa='kubectl get service --all-namespaces'
alias kgswide='kubectl get service -o wide'
alias kds='kubectl describe service'

# Other resources
alias kgcj='kubectl get cronjob'
alias kdcj='kubectl describe cronjob'
alias kgj='kubectl get job'
alias kdj='kubectl describe job'
alias kgds='kubectl get daemonset'
alias kdds='kubectl describe daemonset'
alias kghpa='kubectl get hpa'
alias kdhpa='kubectl describe hpa'
alias kgpvc='kubectl get pvc'
alias kdpvc='kubectl describe pvc'
alias kge='kubectl get events'
alias kgss='kubectl get statefulset'
alias kgno='kubectl get nodes'
alias kgnowide='kubectl get nodes -o wide'
alias kging='kubectl get ingress'
alias kgcm='kubectl get configmap'
alias kgsec='kubectl get secret'
alias kdno='kubectl describe node'

# Rollout
alias krr='kubectl rollout restart'
alias krs='kubectl rollout status'

# Top
alias ktp='kubectl top pods'
alias ktn='kubectl top nodes'

# Logs
alias kl='kubectl logs'
alias klf='kubectl logs -f'
alias klp='kubectl logs --previous'
alias kl1h='kubectl logs --since 1h'
alias kl1m='kubectl logs --since 1m'
alias klf1h='kubectl logs --since 1h -f'
alias klf1m='kubectl logs --since 1m -f'

# Exec
alias keti='kubectl exec -t -i'
