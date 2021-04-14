# Colour escape codes
CYAN='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

echo "🔍 ${GREEN}Checking StatefulSets - ${CYAN}kubectl get statefulsets -o wide${NC}"
kubectl get statefulsets -o wide

echo "\n🔍 ${GREEN}Checking Pods - ${CYAN}kubectl get pods -o wide${NC}"
kubectl get pods -o wide
