# Mini Checkout - backend

This is the backend for a simple checkout tracking web app. It was mainly an exercise to learn Hanami, but is used by a local nonprofit to track sales for an event they run.

See the frontend at https://github.com/bruz/mini-checkout-frontend.

## Install

Prerequisites:

* [Ruby](https://www.ruby-lang.org/en/downloads/)
* [Bundler](http://bundler.io/)
* [PostgreSQL](https://www.postgresql.org/download/)

Setup:

```bash
git clone https://github.com/bruz/mini-checkout-backend
cd mini-checkout-backend
bundle install
hanami db prepare
```

## Development server

```bash
hanami server
```

The API should now be available at http://localhost:2300 to run the frontend against.

## Deploy to Heroku

1. Configure environment variables

```bash
heroku config:set BASIC_AUTH_USER=YOUR-USERNAME BASIC_AUTH_PASS=YOUR-PASSWORD FRONTEND_ORIGIN=https://YOUR-FRONTEND.herokuapp.com
```

2. Deploy!
