# sentry-raven Sanitize Demo

This is a demo project to verify `sentry-raven`'s `Raven::Processor::SanitizeData` can override Rack `env`.

## Usage

### With Docker Compose

```shell
$ git clone https://github.com/ohbarye/senry-raven-sanitize-demo.git
$ cd senry-raven-sanitize-demo
$ echo SENTRY_DSN=<your DSN> > .env
$ docker-compose up -d
$ curl -X POST http://localhost:9292 -F 'name=foo' -F 'age=32'
```

Then you can see a response from rack web server.

```
before: {"name"=>"foo", "age"=>"32"}, after: {"name"=>"********", "age"=>"32"}%
```

### Without Docker Compose

```shell
$ git clone https://github.com/ohbarye/senry-raven-sanitize-demo.git
$ cd senry-raven-sanitize-demo
$ bundle install
$ SENTRY_DSN=<your DSN> bundle exec rackup
$ curl -X POST http://localhost:9292 -F 'name=foo' -F 'age=32'
```

Then you can see a response from rack web server.

```
before: {"name"=>"foo", "age"=>"32"}, after: {"name"=>"********", "age"=>"32"}%
```