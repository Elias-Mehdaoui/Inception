# User Documentation

This document explains how to interact with the Inception infrastructure from an end-user or administrator perspective.

---

## Services Provided by the Stack
* **Main Website**: A fully functional WordPress blog where you can publish articles.

---

## Starting and Stopping the Project
All operations are handled via a simple Makefile at the root of the project.

* **To start everything**: Run `make` or `make all`. This prepares the data folders and launches all services in the background.
* **To stop everything**: Run `make down`. This safely halts the services without deleting your data.
* **To completely reset**: Run `make fclean`. **Warning:** This deletes all containers, networks, and permanently erases your database and website files.

---

## Accessing the Interfaces
Ensure you accept the self-signed SSL certificate warning in your browser before accessing these links.

* **Main Website**: `https://emehdaou.42.fr`
* **WordPress Administration Panel**: `https://emehdaou.42.fr/wp-admin`

---

## Locating and Managing Credentials
Passwords and sensitive data are not hardcoded. As an administrator, you must define them in `.txt` files located in a `secrets/` folder at the root of the repository before starting the project. 

* **Database Root Password**: Stored in `secrets/db_root_password.txt`.
* **Database User Password**: Stored in `secrets/db_password.txt`.
* **WordPress Admin Credentials**: Stored in `secrets/credentials.txt` (Format: `username:password`).

---

## Checking Service Status
To verify that all services are running correctly, open a terminal at the root of the project and run:
`make status`
This will output a list of all containers. Look for the state `Up` next to each service.
