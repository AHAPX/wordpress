## Description
Base wordpress dockers repo.
Images:
* myqsl - mysql db server
* wordpress:fpm - wordpress fpm server (without apache)
* nginx - patched version of nginx (builds/nginx/Dockerfile)

## Installation

### Requirements
- [docker](https://docs.docker.com/engine/installation/)
- [docker-compose](https://docs.docker.com/compose/install/)

### Install system requirements
```bash
$ apt-get update && apt-get install -y git make
$ ssh-keygen
$ cat ~/.ssh/id_rsa.pub
```

### Setup config files
```
$ git clone https://github.com/AHAPX/wordpress
$ cd wordpress
$ make install
```

### Configure
* docker-compose.override.yml - change mysql passwords to complex ones
* nginx/conf.d/default.template - if you need some special nginx settings, you can put them here

## Usage

### Run
```bash
$ make up
```
Wait about a minute after first run, mysql needs a time for setting, you can see a progress using command:

```bash
$ make logs dock=database
```
When you see "*MySQL init process done. Ready for start up.*" your new wordpress website is totally running.

### Stop
```bash
$ make down
```

### Reboot all services
```bash
$ make reboot
```

## Backup and restore

### Backup
```bash
$ make backup
```
the command creates new file in **backups/** folder with name **%Y%m%d%H%M%S.tgz**, where:

* %Y - year
* %m - month
* %d - day
* %H - hours
* %M - minutes
* %S - seconds

i.e. **20160906123510.tgz**

### Restore
```bash
$ make restore file=backups/20160906123510.tgz
```
> !!! be careful, restoration can delete all your wordpress files and mysql database
