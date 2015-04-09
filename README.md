# Nginx Lua Gateway

This is a prototype for an nginx+lua API gateway. The proof of concept is as follows:

  1. `GET /preferences/{userid}` will first authentiate that the user making the
    request is authorized to access the preferences for `userid`.
  2. Nginx will supply a token to an authentication service and if the returned
   `userid` matches the one requested then the request proceeds. If it doesn’t
    match a 403 is returned.
  3. If 2 above succedded then nginx will `proxy_pass` to the backend service.

This is one way to handle the prototyping. Another might be to use
[`content_by_lua_file`](http://wiki.nginx.org/HttpLuaModule#content_by_lua_file) to handle everything.

## Dependencies

Below are the dependencies required on OS X:

```sh
brew install openresty
brew install go
export GOPATH=/usr/local/opt/go/
git clone https://github.com/hashicorp/consul-template.git
cd consul-template
make
```

## Usage

`consul-template` can be used to configure `nginx.conf` with the upstream server.
You can use `bin/templatize` to set this up or just copy `template/nginx.conf`
to `conf/nginx.conf and `replace the go template place holders with your
settings.

To start nginx, run `./scripts/start-nginx`.
