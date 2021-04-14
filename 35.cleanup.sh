# Colour escape codes
CYAN='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

echo "❌ ${GREEN}Removing statefulset.apps/redis - ${CYAN}kubectl delete statefulset.apps/redis --grace-period=0${NC}"
kubectl delete statefulset.apps/redis --grace-period=0
echo "❌ ${GREEN}Removing pvc/task-pv-claim - ${CYAN}kubectl delete pvc/task-pv-claim --grace-period=0${NC}"
kubectl patch pvc task-pv-claim -p '{"metadata":{"finalizers":null}}'
kubectl delete pvc/task-pv-claim --grace-period=0
echo "❌ ${GREEN}Removing pv/task-pv-volume ${CYAN}kubectl delete pv/task-pv-volume --grace-period=0${NC}"
kubectl delete pv/task-pv-volume --grace-period=0

# Untaint node1,2,3
kubectl taint nodes storageos-k8s1 exclusive=true:NoSchedule- --overwrite &> /dev/null; echo "✅ ${GREEN}UnTainted storageos-k8s1 - ${CYAN}kubectl taint nodes storageos-k8s1 exclusive=true:NoSchedule-${NC}"
kubectl taint nodes storageos-k8s2 exclusive=true:NoSchedule- --overwrite &> /dev/null; echo "✅ ${GREEN}UnTainted storageos-k8s2 - ${CYAN}kubectl taint nodes storageos-k8s2 exclusive=true:NoSchedule-${NC}"
kubectl taint nodes storageos-k8s3 exclusive=true:NoSchedule- --overwrite &> /dev/null; echo "✅ ${GREEN}UnTainted storageos-k8s3 - ${CYAN}kubectl taint nodes storageos-k8s3 exclusive=true:NoSchedule-${NC}"
