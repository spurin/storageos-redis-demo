# Colour escape codes
CYAN='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

echo "❌ ${GREEN}Removing redis pod - ${CYAN}kubectl delete pod redis-0 --grace-period=0${NC}"
kubectl delete pod redis-0 --grace-period=0
