# GSLTCTRL-RS docker image

This repository is based on the work of [991jo's ](https://github.com/991jo) [GSLTCTRL-RS](https://github.com/991jo/GSLTCTRL-RS.git) .

## Linux Container

[![linux/amd64](https://github.com/Lan2Play/docker-gsltctrl/actions/workflows/build-linux-image.yml/badge.svg?branch=main)](https://github.com/Lan2Play/docker-gsltctrl/actions/workflows/build-linux-image.yml)

### Download

```shell
docker pull lan2play/docker-gsltctrl;
```

### usage

```shell
docker run --rm -e GSLTCTRL_TOKEN=YOURAPIKEY lan2play/docker-gsltctrl <appid> '<memo>'
```

