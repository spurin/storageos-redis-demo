# Colour escape codes
CYAN='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

# Taint node1, taint node 2, untaint node 3
kubectl taint nodes storageos-k8s1 exclusive=true:NoSchedule --overwrite &> /dev/null && echo "⚠️  ${GREEN}Tainted storageos-k8s1 - ${CYAN}kubectl taint nodes storageos-k8s1 exclusive=true:NoSchedule --overwrite${NC}"
kubectl taint nodes storageos-k8s2 exclusive=true:NoSchedule --overwrite &> /dev/null && echo "⚠️  ${GREEN}Tainted storageos-k8s2 - ${CYAN}kubectl taint nodes storageos-k8s2 exclusive=true:NoSchedule --overwrite${NC}"
kubectl taint nodes storageos-k8s3 exclusive=true:NoSchedule- --overwrite &> /dev/null; echo "✅ ${GREEN}UnTainted storageos-k8s3 - ${CYAN}kubectl taint nodes storageos-k8s3 exclusive=true:NoSchedule- --overwrite${NC}"
