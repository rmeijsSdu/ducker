# Ducker

## Status

Working, but currently only shows static page.

## ToDo

- [ ] make sure it (also) works as a proxy image

## Goal

Automatically configure `nginx` proxy for multiple domains with letsencrypt certificates. The domains need to be under your control and have to point to the IP where this Docker image is run.

## Environment variables

- `HOSTS` contains the various hosts seperated by `;`
- `EMAIL` email address of letsencrypt requester.

## Usage

```sh
docker run -e "HOSTS=host1.example.com;host2.example.com" -e "EMAIL=yo@bro.com" -p 8080:80 -p 8081:443 sinnerr/ducker:latest
```

## Based on

<https://github.com/nginxinc/docker-nginx>
