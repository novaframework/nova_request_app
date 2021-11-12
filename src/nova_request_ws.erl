-module(nova_request_ws).

-export([init/1,
         websocket_init/1,
         websocket_handle/2,
         websocket_info/2,
         terminate/3]).

init(State) ->
    {ok, State}.

websocket_init(#{req := #{bindings := #{<<"ws">> := Ws}}}) ->
    self() ! Ws,
    {ok, Ws}.

websocket_handle(Unexpected, State) ->
    logger:warning("UNEXPECTED: ~p State: ~p~n", [Unexpected, State]),
    {ok, State}.

websocket_info(Ws, State) ->
    {reply, {text, Ws}, State}.

terminate(_, _, _) ->
    ok.