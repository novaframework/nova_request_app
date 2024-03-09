-module(nova_request_auth).

-export([auth/1]).

auth(#{correlation_id := _CorrId}) ->
    {true, #{<<"this">> => <<"auth_data">>}}.