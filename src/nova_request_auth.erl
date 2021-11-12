-module(nova_request_auth).

-export([auth/1]).

auth(_) ->
    {true, #{<<"this">> => <<"auth_data">>}}.