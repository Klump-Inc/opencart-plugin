### Installation.
To run this project, you will need the latest version of [Docker](https://docker.com) installed.

In the project directory, run `make rebuild` on your terminal and open `localhost:8080` on your browser. When asked for detals during installation, enter the following:
```
MYSQL_DATABASE: opencart
MYSQL_USER: user
MYSQL_PASSWORD: password
MYSQL_ROOT_PASSWORD: password
MYSQL_HOST: klump_mysql
```
When setup and installations are completed, delete the `/install/` directory. You can do that by SSHing into the docker container via `ssh_opencart` and running `rm -rf install` within the container.

### Admin
Go to http://localhost:8080/admin/ and login with the following details:
```
Username: admin
Password: admin
```

You will be prompted to change storage directory, give it a name that workds for you and change the admin directory to something like `admin1`. You will be redirected to login again and do so with `localhost:8080/admin1`