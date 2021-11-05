-module(nova_request_app_main_controller).
-export([
         get_qs/1,
         post_params/1,
         json_post/1,
         json_get/1
        ]).

-include_lib("nova/include/nova.hrl").

get_qs(#{parsed_qs := Qs}) ->
    {json, Qs}.

post_params(#{params := Params}) ->
    {json, Params}.

json_post(#{json := Json}) ->
    {json, Json}.

json_get(_) ->
    Json = #{<<"test">> => <<"json">>},
    {json, Json}.

json_get_binding(#{bindings := #{json := Json}}) ->
    Json2 = #{<<"test">> => Json},
    {json, Json2}.