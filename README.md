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
  {sid,        "YOUR_SID"},
  {auth_token, "YOUR_AUTH_TOKEN"},
  {phone,      "YOUR_PHONE"}
]}
```

Usage
-----

```Erlang
etwilio:send_sms("380931234567", "Hello, Mike!").
```
