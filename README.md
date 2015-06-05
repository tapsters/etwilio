# Etwilio
An Erlang library for communicating with the Twilio API and send SMS

Installing
----------

In sys.config

```
  {twilio, [
    {sid,           "XXXXXXXXXX"},
    {auth_token,    "XXXXXXXXXX"},
    {phone,         "XXXXXXXXXX"}
  ]}
```

Use
----------

```etwilio:send_sms("380930000000", "Text message").```
