%% Feel free to use, reuse and abuse the code in this file.

%% @doc Hello world handler.
-module(mycowboy_handler).

-export([init/3]).
-export([content_types_provided/2]).
-export([hello_to_html/2]).
-export([hello_to_json/2]).
-export([hello_to_text/2]).
-export([handle_html/2]).

init(_Transport, _Req, []) ->
  {upgrade, protocol, cowboy_rest}.

content_types_provided(Req, State) ->
  {[
    {<<"text/html">>, handle_html},
    {<<"application/json">>, hello_to_json},
    {<<"text/plain">>, hello_to_text}
  ], Req, State}.

handle_html(Req, State) ->
  {Path, _Req1} = cowboy_req:path_info(Req),
  io:format("Path: ~p~n", [Path]),
  Body = handle(Path),
  {Body, Req, State}.

handle([<<"monitorings">>]) ->
  "Monitorings!";

handle([<<"monitorings">>, Id]) ->
  Monitoring = {[
    {monitoring, {[
                    {id, Id}
                 ]}
    }
  ]},
  jiffy:encode(Monitoring);

handle(Other) ->
  io_lib:format("Unknown path ~p~n", [Other]).

hello_to_html(Req, State) ->
  {Path, Req1} = cowboy_req:path_info(Req),
  io:format("Path: ~p Req1: ~p", [Path, Req1]),
  Body = <<"<html>
<head>
  <meta charset=\"utf-8\">
  <title>REST Hello World!</title>
</head>
<body>
  <p>REST Hello World as HTML!</p>
</body>
</html>">>,
  {Body, Req, State}.

hello_to_json(Req, State) ->
  Body = <<"{\"rest\": \"Hello World!\"}">>,
  {Body, Req, State}.

hello_to_text(Req, State) ->
  {<<"REST Hello World as text!">>, Req, State}.