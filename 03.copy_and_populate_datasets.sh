# Colour escape codes
CYAN='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

echo "๐พ ${GREEN}Copying Dataset to redis-0:/tmp - ${CYAN}kubectl cp redis-datasets redis-0:/tmp${NC}"
kubectl cp redis-datasets redis-0:/tmp

echo "โ ${GREEN}Importing Redis Datasets -${NC}"
echo "  - ๐ฅ ${GREEN}Films - ${CYAN}kubectl exec -it redis-0 -- sh -c \"cat /tmp/redis-datasets/movie-database/import_movies.redis | redis-cli --pipe -h localhost -p 6379\"${NC}"
kubectl exec -it redis-0 -- sh -c "cat /tmp/redis-datasets/movie-database/import_movies.redis | redis-cli --pipe -h localhost -p 6379" 2>&1 | grep real

echo "  - ๐คจ ${GREEN}Actors - ${CYAN}kubectl exec -it redis-0 -- sh -c \"cat /tmp/redis-datasets/movie-database/import_actors.redis | redis-cli --pipe -h localhost -p 6379\"${NC}"
kubectl exec -it redis-0 -- sh -c "cat /tmp/redis-datasets/movie-database/import_actors.redis | redis-cli --pipe -h localhost -p 6379" >/dev/null

echo "  - ๐ค ${GREEN}Users - ${CYAN}kubectl exec -it redis-0 -- sh -c \"cat /tmp/redis-datasets/user-database/import_users.redis | redis-cli --pipe -h localhost -p 6379\"${NC}"
kubectl exec -it redis-0 -- sh -c "cat /tmp/redis-datasets/user-database/import_users.redis | redis-cli --pipe -h localhost -p 6379" >/dev/null

#echo "  - ๐ Large Dataset - kubectl exec -it redis-0 -- sh -c \"gunzip -c /tmp/redis-datasets/test.txt.gz | redis-cli --pipe -h localhost -p 6379\""
#kubectl exec -it redis-0 -- sh -c "gunzip -c /tmp/redis-datasets/test.txt.gz | redis-cli --pipe -h localhost -p 6379" >/dev/null
