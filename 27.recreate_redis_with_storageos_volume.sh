# Colour escape codes
CYAN='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

echo "❌ ${GREEN}Removing statefulset.apps/redis - ${CYAN}kubectl delete statefulset.apps/redis --grace-period=0${NC}"
kubectl delete statefulset.apps/redis --grace-period=0
echo "❌ ${GREEN}Removing pvc/task-pv-claim - ${CYAN}kubectl delete pvc/task-pv-claim --grace-period=0${NC}"
kubectl delete pvc/task-pv-claim --grace-period=0
echo "❌ ${GREEN}Removing pv/task-pv-volume ${CYAN}kubectl delete pv/task-pv-volume --grace-period=0${NC}"
kubectl delete pv/task-pv-volume --grace-period=0

echo "✨ ${GREEN}Recreating Redis with StorageOS Persistent Volumes - 2 Replicas - ${CYAN}kubectl apply -f- <<EOF"

read -r -d '' YAML << EOF
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: task-pv-claim
  labels:
    storageos.com/replicas: "2" # 3 Copies of the data - Primary, Replica-1, Replica-2
spec:
  storageClassName: fast
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: redis
spec:
  selector:
    matchLabels:
      app: redis
  serviceName: redis
  replicas: 1
  template:
    metadata:
      labels:
        app: redis
    spec:
      volumes:
      - name: task-pv-storage
        persistentVolumeClaim:
          claimName: task-pv-claim
      containers:
        - name: redis
          image: redis:6
          imagePullPolicy: Always
          args: ["--appendonly", "yes", "--save", "30", "100"]
          ports:
            - containerPort: 6379
              name: redis
          volumeMounts:
          - mountPath: "/data"
            name: task-pv-storage
EOF

echo "${YAML}\nEOF${NC}"

kubectl apply -f- <<< "$YAML"
