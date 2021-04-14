# Colour escape codes
CYAN='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

echo "✨ ${GREEN}Reconfiguring Redis with RDB and AOF - ${CYAN}kubectl apply -f- <<EOF"

read -r -d '' YAML << EOF
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
      containers:
        - name: redis
          image: redis:6
          imagePullPolicy: Always
          args: ["--appendonly", "yes", "--save", "30", "100"]
          ports:
            - containerPort: 6379
              name: redis
EOF

echo "${YAML}\nEOF${NC}"

kubectl apply -f- <<< "$YAML"
