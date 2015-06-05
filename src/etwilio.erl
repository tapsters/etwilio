-module(etwilio).
-author("Evgeniy Lopatenko").

-export([
  send_sms/2
]).

send_sms(Phone, Message) ->
  {ok,        Sid} = application:get_env(twilio, sid),
  {ok,  FromPhone} = application:get_env(twilio, phone),
  {ok,  AuthToken} = application:get_env(twilio, auth_token),

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
      {struct, Json} = decode_json(Data),
      {error, proplists:get_value("message", Json, "Failed to send sms (bad request)")};
    {ok, {{"HTTP/1.1", 401, "UNAUTHORIZED"}, _, Data}} ->
      {struct, Json} = decode_json(Data),
      {error, proplists:get_value("detail", Json, "Failed to send sms (unauthorized)")};
    _ ->
      {error, "Failed to send sms (unknown error)"}
  end.

decode_json(Data) ->
  {ok, Document} = yaws_json2:decode_string(Data), Document.
