-module(nova_request_app_main_controller).
-export([
         get_qs/1,
         post_params/1,
         json_post/1,
         json_get/1,
         json_get_binding/1,
         all/1,
         secure/1,
         internal_server_error/1
        ]).

get_qs(#{parsed_qs := Qs}) ->
    {json, Qs}.

post_params(#{params := Params}) ->
    {json, Params}.

json_post(#{json := Json}) ->
    {json, Json}.

json_get(_) ->
    Json = #{<<"test">> => <<"json">>},
    {json, Json}.

json_get_binding(#{bindings := #{<<"json">> := Json}}) ->
    Json2 = #{<<"test">> => Json},
    {json, Json2}.

all(_) ->
    Json = [#{ <<"id">> => X} || X <- lists:seq(1, 10)],
    {json, Json}.

secure(#{bindings := #{<<"secure">> := Secure},
         auth_data := #{<<"this">> := <<"auth_data">>}}) ->
    {json, #{<<"secure">> => Secure}}.

internal_server_error(_) ->
    1 = 2,
    {json, 2}.