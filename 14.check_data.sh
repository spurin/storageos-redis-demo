# Colour escape codes
CYAN='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

echo "💾 ${GREEN}Checking /data - ${CYAN}kubectl exec -it redis-0 -- sh -c \"ls -alh /data\"${NC}" 
kubectl exec -it redis-0 -- sh -c "ls -alh /data"
