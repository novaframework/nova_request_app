-module(nova_request_app_router).
-behaviour(nova_router).

-export([routes/1]).

routes(_) ->
    no_fun() ++ with_fun().

no_fun() ->
  [#{prefix => "",
       security => false,
       routes => [
                  {"/", { nova_request_app_main_controller, json_get}, #{methods => [get]}},
                  {"/get_qs", { nova_request_app_main_controller, get_qs}, #{methods => [get]}},
                  {"/post_params", { nova_request_app_main_controller, post_params}, #{methods => [post]}},
                  {"/json_post", { nova_request_app_main_controller, json_post}, #{methods => [post]}},
                  {"/json_get", { nova_request_app_main_controller, json_get}, #{methods => [get]}},
                  {"/ws/:ws", nova_request_ws, #{protocol => ws}},
                  {"/session/:session", {nova_request_app_main_controller, session}, #{methods => [get]}},
                  {"/internalerror", { nova_request_app_main_controller, internal_server_error}, #{methods => [get]}},
                  {"/fallback", { nova_request_app_main_controller, fallback}, #{methods => [get]}},
                  {"/viewok", { nova_request_app_main_controller, return_view_with_ok}, #{methods => [get]}},
                  {"/viewview", { nova_request_app_main_controller, return_view_with_view}, #{methods => [get]}}
                 ]
      },
      #{prefix => "/json_binding",
        security => false,
        routes => [{"/", {nova_request_app_main_controller, all}, #{methods => [get]}},
                   {"/:json/", { nova_request_app_main_controller, json_get_binding}, #{methods => [get]}}
                  ]
        },
      #{prefix => "/secure",
        security => {nova_request_auth, auth},
        routes => [{"/:secure", {nova_request_app_main_controller, secure}, #{methods => [get]}},
                   {"/apanws/:ws", nova_request_ws, #{protocol => ws}}]
      },
      #{prefix => "/user/:userid",
        security => false,
        routes => [
                   {"/", {nova_request_app_main_controller, get_user}, #{methods => [get]}},
                   {"/", {nova_request_app_main_controller, delete_user}, #{methods => [delete]}}

      ]},
          #{prefix => "",
        security => false,
        routes => [{"/trailingslash/", {nova_request_app_main_controller, json_get}, #{methods => [get]}}]}].

with_fun() ->
  [#{prefix => "/fun/",
        security => false,
        routes => [
                  {"/",  fun nova_request_app_main_controller:json_get/1, #{methods => [get]}},
                  {"/get_qs",  fun nova_request_app_main_controller:get_qs/1, #{methods => [get]}},
                  {"/post_params", fun nova_request_app_main_controller:post_params/1, #{methods => [post]}},
                  {"/json_post", fun nova_request_app_main_controller:json_post/1, #{methods => [post]}},
                  {"/json_get", fun nova_request_app_main_controller:json_get/1, #{methods => [get]}},
                  {"/ws/:ws", nova_request_ws, #{protocol => ws}},
                  {"/session/:session", fun nova_request_app_main_controller:session/1, #{methods => [get]}},
                  {"/internalerror", fun nova_request_app_main_controller:internal_server_error/1 , #{methods => [get]}},
                  {"/fallback", fun nova_request_app_main_controller:fallback/1, #{methods => [get]}},
                  {"/viewok", fun nova_request_app_main_controller:return_view_with_ok/1, #{methods => [get]}},
                  {"/viewview", fun nova_request_app_main_controller:return_view_with_view/1 , #{methods => [get]}},
                  {"/trailingslash/", fun nova_request_app_main_controller:json_get/1, #{methods => [get]}},
                  {"/heartbeat", fun(_) -> {status, 200} end, #{methods => [get]}}
                  ]
      },
      #{prefix => "/fun/json_binding",
        security => false,
        routes => [{"/", fun nova_request_app_main_controller:all/1, #{methods => [get]}},
                    {"/:json/", fun nova_request_app_main_controller:json_get_binding/1, #{methods => [get]}}
                  ]
        },
      #{prefix => "/fun/secure",
        security => fun nova_request_auth:auth/1,
        routes => [{"/:secure", fun nova_request_app_main_controller:secure/1 , #{methods => [get]}},
                    {"/apanws/:ws", nova_request_ws, #{protocol => ws}}]
      },
      #{prefix => "/fun/user/:userid",
        security => false,
        routes => [
                    {"/", fun nova_request_app_main_controller:get_user/1, #{methods => [get]}},
                    {"/", fun nova_request_app_main_controller:delete_user/1, #{methods => [delete]}}]
       },
      #{prefix => "/fun/json_schemas",
          security => false,
          plugins => [
                      {pre_request, nova_request_plugin, #{decode_json_body => true}},
                      {pre_request, nova_json_schemas, #{render_errors => true}}
                      ],
          routes => [
                      {"/", fun(_) -> {status, 200} end,
                      #{methods => [post], extra_state => #{ json_schema => "./schemas/sample_json_schema.json" }}}]
       }
].
