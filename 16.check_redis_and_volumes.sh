# Colour escape codes
CYAN='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

echo "š ${GREEN}Checking StatefulSets - ${CYAN}kubectl get statefulsets -o wide${NC}"
kubectl get statefulsets -o wide

echo "\nš ${GREEN}Checking Pods - ${CYAN}kubectl get pods -o wide${NC}"
kubectl get pods -o wide

echo "\nš ${GREEN}Checking PV's - ${CYAN}kubectl get pv${NC}"
kubectl get pv

echo "\nš ${GREEN}Checking PVC's - ${CYAN}kubectl get pvc${NC}"
kubectl get pvc
