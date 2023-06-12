atopVersion="1.0.1"
env=dev
namespace=top

helm repo update

helm upgrade --install  $env  atop/atop --version $atopVersion --create-namespace --namespace $namespace -f values.yaml --set env=$env
 


#helm upgrade --install apisix atop/apisix --create-namespace --namespace apisix --set gateway.http.nodePort=31690 --set dashboard.enabled=true --set ingress-controller.enabled=true --set ingress-controller.config.apisix.serviceNamespace=apisixg