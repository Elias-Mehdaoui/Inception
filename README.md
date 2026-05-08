*This project has been created as part of the 42 curriculum by emehdaou.*

## Description
Inception is a system administration project that introduces the concepts of containerization using Docker. The goal is to broaden your knowledge of system administration by deploying a multi-service, isolated IT infrastructure running on a single machine. 

This project orchestrates a complete LEMP stack (Linux, NGINX, MariaDB, PHP) alongside several bonus services using Docker Compose. Every service runs in its own dedicated container, built from a lightweight Alpine Linux base image to maximize performance and security.

### Design Choices & Sources
* **Base Image**: Alpine Linux 3.22 is used for all containers due to its minimal footprint and security-oriented design.
* **Process Management**: Custom bash entrypoint scripts are used to initialize configurations (like wp-cli for WordPress) before handing over control to the main daemon (e.g., php-fpm, nginx) running in the foreground.
* **Sources**: The infrastructure includes NGINX (Reverse Proxy), MariaDB (Database), WordPress (CMS), Redis (Object Cache), Adminer (Database UI), vsftpd (FTP Server), Lighttpd (Static Site), and GoAccess (Log Analytics).

### Technical Comparisons

**Virtual Machines vs Docker**
Virtual Machines rely on hardware-level virtualization, requiring a full guest operating system for each instance, which consumes significant RAM and CPU. Docker uses OS-level virtualization, sharing the host's Linux kernel while isolating processes in containers. This makes Docker significantly faster to start, more resource-efficient, and highly portable.

**Secrets vs Environment Variables**
Environment variables are injected directly into the container's environment and can easily be leaked through crash logs, debugging tools (`docker inspect`), or child processes. Docker Secrets are securely mounted as read-only files in an in-memory filesystem (tmpfs). They are never saved to disk in the container, making them the superior choice for handling database passwords and credentials.

**Docker Network vs Host Network**
The Host network mode removes network isolation, attaching the container directly to the host's network interfaces. This is insecure for a multi-service stack. A dedicated Docker Network (custom bridge) provides a private subnet where containers can securely communicate using internal DNS resolution (e.g., WordPress pinging the `mariadb` container by name), while only explicitly mapped ports (like 443 for NGINX) are exposed to the outside world.

**Docker Volumes vs Bind Mounts**
Bind mounts map an explicit, absolute path on the host system to a directory inside the container. They depend heavily on the host's file structure. Docker Volumes are fully managed by Docker within its own storage directory, ensuring better cross-platform compatibility and safety. For this project, we used local volume drivers configured to act like bind mounts to satisfy the specific requirement of storing data in `/home/emehdaou/data/`.

---

## Instructions

### Prerequisites
* A Linux host or Virtual Machine (Debian/Fedora recommended).
* Docker Engine and Docker Compose installed.
* Make installed.
* Domain mapping configured: Map `emehdaou.42.fr` to `127.0.0.1` in your host's `/etc/hosts` file.

### Compilation & Installation
1. Clone the repository and navigate to the project root.
2. Ensure the secret files (passwords) are correctly placed in the `/secrets/` directory.
3. Run the setup and build command:
   `make all`

### Execution
Once the build is complete, the infrastructure runs in the background. Access the main site via your web browser at `https://emehdaou.42.fr`. Use `make down` to gracefully stop the containers, or `make status` to view their health.

---

## Resources
* [Docker Official Documentation](https://docs.docker.com/)
* [NGINX Reverse Proxy Configuration](https://nginx.org/en/docs/http/ngx_http_proxy_module.html)
* [WP-CLI Documentation](https://make.wordpress.org/cli/handbook/)
* [Alpine Linux Package Management](https://wiki.alpinelinux.org/wiki/Alpine_Package_Keeper)

**AI Usage**

* **NO AI policy**
