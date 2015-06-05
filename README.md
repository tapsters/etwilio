# etwilio
An Erlang library for sending SMS via Twilio API

Installing
----------

In rebar.config:

```Erlang
{etwilio, ".*", {git, "git://github.com/tapsters/etwilio", {tag, "master"}}}
```

In sys.config:

```Erlang
{twilio, [
  {sid,        "DS9c2a3br044a4c9534207c98bc7b42db1"},
  {auth_token, "7213eeebc23894062bbc24fce1807976"},
  {phone,      "%2B13123456789"}
]}
```

Usage
-----

```Erlang
etwilio:send_sms("380931234567", "Hello, Mike!").
```
