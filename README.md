
![Screenshot_94](https://github.com/6Ministers/flectra-3-dev-docker-compose/assets/11208423/d29a6c37-4ebc-4142-b3dc-f4dd6a43ddde)

# Installing FlectraHQ 3.0 ALFA with one command (Supports multiple FlectraHQ instances on one server). For development.

## Quick Installation

Run for Ubuntu 22.04

``` bash
sudo apt-get purge needrestart
```

Install docker and docker-compose:

``` bash
curl -s https://raw.githubusercontent.com/6Ministers/flectra-3-dev-docker-compose/master/setup.sh | sudo bash -s
```

Run the following to set up first Flectra instance @ `localhost:10020` (default master password: `master.password`):

``` bash
curl -s https://raw.githubusercontent.com/6Ministers/flectra-3-dev-docker-compose/master/run.sh | sudo bash -s flectra-one 10020 20020
```
and/or run the following to set up another Flectra instance @ `localhost:11020` (default master password: `master.password`):

``` bash
curl -s https://raw.githubusercontent.com/6Ministers/flectra-3-dev-docker-compose/master/run.sh | sudo bash -s flectra-two 11020 21020
```

Some arguments:
* First argument (**flectra-one**): Flectra deploy folder
* Second argument (**10020**): Flectra port
* Third argument (**20020**): live chat port

If `curl` is not found, install it:

``` bash
$ sudo apt-get install curl
# or
$ sudo yum install curl
```

## Usage

Start the container:
``` sh
docker-compose up
```
Then open `localhost:10020` to access Flectra 3.0.

- **If you get any permission issues**, change the folder permission to make sure that the container is able to access the directory:

``` sh
$ sudo chmod -R 777 addons
$ sudo chmod -R 777 etc
$ sudo chmod -R 777 postgresql
```

- If you want to start the server with a different port, change **10020** to another value in **docker-compose.yml** inside the parent dir:

```
ports:
 - "10020:7073"
```

- To run Flectra container in detached mode (be able to close terminal without stopping Flectra):

```
docker-compose up -d
```

- To Use a restart policy, i.e. configure the restart policy for a container, change the value related to **restart** key in **docker-compose.yml** file to one of the following:
   - `no` =	Do not automatically restart the container. (the default)
   - `on-failure[:max-retries]` =	Restart the container if it exits due to an error, which manifests as a non-zero exit code. Optionally, limit the number of times the Docker daemon attempts to restart the container using the :max-retries option.
  - `always` =	Always restart the container if it stops. If it is manually stopped, it is restarted only when Docker daemon restarts or the container itself is manually restarted. (See the second bullet listed in restart policy details)
  - `unless-stopped`	= Similar to always, except that when the container is stopped (manually or otherwise), it is not restarted even after Docker daemon restarts.
```
 restart: always             # run as a service
```

- To increase maximum number of files watching from 8192 (default) to **524288**. In order to avoid error when we run multiple Flectra instances. This is an *optional step*. These commands are for Ubuntu user:

```
$ if grep -qF "fs.inotify.max_user_watches" /etc/config/sysctl.conf; then echo $(grep -F "fs.inotify.max_user_watches" /etc/config/sysctl.conf); else echo "fs.inotify.max_user_watches = 524288" | sudo tee -a /etc/config/sysctl.conf; fi
$ sudo sysctl -p    # apply new config immediately
``` 

## Custom addons

The **addons/** folder contains custom addons. Just put your custom addons if you have any.

## Flectra configuration & log

* To change Flectra configuration, edit file: **etc/flectra.conf**.
* Log file: **etc/flectra-server.log**
* Default database password (**admin_passwd**) is ``master.password`, please change it @ [/etc/config/flectra.conf#L60](/etc/config/flectra.conf#L60)
  

## Flectra container management

**Run Flectra**:

``` bash
docker-compose up -d
```

**Restart Flectra**:

``` bash
docker-compose restart
```

**Stop Flectra**:

``` bash
docker-compose down
```

**Restart**:

``` bash
sudo docker-compose down && sudo docker-compose up -d
```

## Live chat



## docker-compose.yml

* flectrahq/flectra:3.0
* postgres:16

![Screenshot_95](https://github.com/6Ministers/flectra-3-dev-docker-compose/assets/11208423/046ac5e0-15b5-43fa-b273-0f695fb15ab3)
