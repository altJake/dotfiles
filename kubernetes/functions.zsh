# Shell into a pod matched by label selector
# Usage: kshl app=myapp [shell]
kshl() {
  pod=$(kgp -l "$1" -o name | head -n1)
  kubesh $pod "$2"
}

# Switch context and namespace in one command
# Usage: knx my-context my-namespace
knx() {
  kcx "$1" && kns "$2"
}
