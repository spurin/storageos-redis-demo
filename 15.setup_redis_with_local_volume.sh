# Colour escape codes
CYAN='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

echo "✨ ${GREEN}Reconfiguring Redis with a Persistent Volume and a Persistent Volume Claim - ${CYAN}kubectl apply -f- <<EOF"

read -r -d '' YAML << EOF
apiVersion: v1
kind: PersistentVolume
metadata:
  name: task-pv-volume
  labels:
    type: local
spec:
  storageClassName: local-storage
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/tmp/$(uuidgen)"
    type: DirectoryOrCreate
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: task-pv-claim
spec:
  storageClassName: local-storage
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
