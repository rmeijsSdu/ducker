# Ducker

## Status

Working proof-of-concept, shows static page or proxys to backend.

Not production ready since it might run into limitations as outlined on: <https://letsencrypt.org/docs/rate-limits/>.

## ToDo

- [X] make sure it (also) works as a proxy image;
- [ ] make production ready.

## Goal

Automatically configure `nginx` proxy for multiple domains with letsencrypt certificates. The domains need to be under your control and have to point to the IP where this Docker image is run.

## Environment variables

- `HOSTS` contains the various hosts seperated by `;`
- `EMAIL` email address of letsencrypt requester.
- `BACKENDBASEURL` url of the backend e.g. `http://123.123.123.123/`.

## Usage

Ducker can be used in two ways.

First one to only test the letsencrypt certs is to serve a static page for all hosts.

```sh
docker run -e "HOSTS=host1.example.com;host2.example.com" -e "EMAIL=yo@bro.com" -p 8080:80 -p 8081:443 sinnerr/ducker:latest
```

Second is to proxy the requests to a backend system. The 'BACKENDBASEURL` environment variable needs to be set.

E.g.

```sh
docker run -e "HOSTS=host1.example.com;host2.example.com" -e "EMAIL=yo@bro.com" -e "BACKENDBASEURL=http://123.123.123.123/" -p 8080:80 -p 8081:443 sinnerr/ducker:latest
```

Requests are routed to: `http://123.123.123.123/host1.example.com` & `http://123.123.123.123/host2.example.com`.

## Based on

<https://github.com/nginxinc/docker-nginx>
