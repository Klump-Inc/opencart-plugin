start up:
	clear && docker compose up -d

#Show dashboard logs
start_with_logs:
	clear && docker compose up -d && docker compose logs -f

#Rebuild dashboard environment
rebuild:
	clear && docker-compose build --no-cache && docker compose down --remove-orphans  && docker compose rm -f && docker compose up --build -d --force-recreate && docker compose logs -f

ssh_opencart:
	docker exec -it klump_opencart bash

#stop dashboard
stop down:
	clear && docker compose down --remove-orphans && docker compose rm
