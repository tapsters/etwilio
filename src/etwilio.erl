-module(etwilio).
-author("Evgeniy Lopatenko").

-export([
  send_sms/2
]).

send_sms(Phone, Message) ->
  {ok,        Sid}  = application:get_env(twilio, sid),
  {ok,  FromPhone}  = application:get_env(twilio, phone),
  {ok,  AuthToken}  = application:get_env(twilio, auth_token),

  Output = httpc:request(post, {
      "https://api.twilio.com/2010-04-01/Accounts/" ++ Sid ++ "/Messages.json",
    [{"Authorization", "Basic " ++ base64:encode_to_string(Sid ++ ":" ++ AuthToken)}],
    "application/x-www-form-urlencoded",
      "Body=" ++ Message ++ "&To=%2B" ++ Phone ++ "&From="++ FromPhone
  }, [], []),

  case Output of
    {ok, {{"HTTP/1.1", 201, "CREATED"}, _, _Data}} ->
      ok;
    {ok, {{"HTTP/1.1", 400, "BAD REQUEST"}, _, Data}} ->
      {struct, Json} = sm:json_dec(Data),
      case sm:prop("message", Json) of
        List -> {error, List};
        _    -> {error, "Failed to send sms"}
      end;
    {ok, {{"HTTP/1.1", 401, "UNAUTHORIZED"}, _, Data}} ->
      {struct, Json} = sm:json_dec(Data),
      case sm:prop("detail", Json) of
        List -> {error, List};
        _    -> {error, "Failed to send sms"}
      end;
    _ ->
      {error, "Failed to send sms"}
  end.
