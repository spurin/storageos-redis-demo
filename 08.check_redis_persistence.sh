# Colour escape codes
CYAN='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

echo "🔎 ${GREEN}Checking Redis Persistence\n"
echo "${CYAN}kubectl exec -it redis-0 -- sh -c \"echo 'config get save' | redis-cli\"${NC}"
kubectl exec -it redis-0 -- sh -c "echo 'config get save' | redis-cli"
echo
echo "${CYAN}kubectl exec -it redis-0 -- sh -c \"echo 'config get appendonly' | redis-cli\"${NC}"
kubectl exec -it redis-0 -- sh -c "echo 'config get appendonly' | redis-cli"
