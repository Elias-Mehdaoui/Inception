# Developer Documentation

This document provides technical details for developers who need to build, modify, or troubleshoot the Inception infrastructure.

---

## Environment Setup
To set up the environment from scratch, follow these prerequisites:

1. **Host Configuration**: The domain `emehdaou.42.fr` must resolve to `127.0.0.1`. Modify `/etc/hosts` to include: `127.0.0.1 emehdaou.42.fr`.
2. **Secrets Initialization**: Create a folder named `secrets` at the root of the project. Create three files (`db_root_password.txt`, `db_password.txt`, `credentials.txt`) and populate them with plain-text secure passwords.
3. **Environment Variables**: A `.env` file must be present inside the `srcs/` directory containing necessary variables such as `DOMAIN_NAME`, `MYSQL_DATABASE`, and `MYSQL_USER`.

---

## Build and Launch Process
The project utilizes a `Makefile` that acts as a wrapper around Docker Compose. 

1. **`make build`**: Executes pre-launch checks, explicitly creating the required host directories (`/home/emehdaou/data/mariadb` and `/home/emehdaou/data/wordpress`) to prevent Docker volume mounting errors.
2. **`docker compose up -d --build`**: Triggered automatically by `make all`. It reads `srcs/docker-compose.yml`, builds the Dockerfiles for all defined services based on Alpine Linux, establishes the `inception` bridge network, and starts the containers in detached mode.

---

## Managing Containers and Volumes
Use the following commands for deep debugging and management:

* **Open a shell inside a container**: `docker exec -it <container_name> sh` (e.g., `docker exec -it wordpress sh`).
* **View real-time logs of a specific service**: `docker compose -f srcs/docker-compose.yml logs -f <container_name>`.
* **Execute WP-CLI commands**: `docker exec -it wordpress wp <command> --allow-root`.
* **Clean orphaned resources**: `make clean` handles stopping containers and pruning unused Docker networks and dangling images.

---

## Data Storage and Persistence
Persistence is strictly configured according to project rules, ensuring data survives container destruction.

* **Database Storage**: MariaDB data is written to `/var/lib/mysql` inside the container. This path is bound to `/home/emehdaou/data/mariadb` on the host machine.
* **Web Files Storage**: WordPress core files, plugins, and uploaded media are written to `/var/www/html` inside the container. This is bound to `/home/emehdaou/data/wordpress` on the host machine.
* **Volume Configuration**: The `docker-compose.yml` uses local volume drivers with `o: bind` options to enforce these exact host paths, allowing services like NGINX and FTP to share the `wordpress_data` volume seamlessly.
