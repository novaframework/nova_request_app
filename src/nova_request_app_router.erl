-module(nova_request_app_router).
-behaviour(nova_router).

-export([routes/1]).

routes(_) ->
    [#{prefix => "",
    security => false,
    routes => [
              {"/get_qs", { nova_request_app_main_controller, get_qs}, #{methods => [get]}},
              {"/post_params", { nova_request_app_main_controller, post_params}, #{methods => [post]}},
              {"/json_post", { nova_request_app_main_controller, json_post}, #{methods => [post]}},
              {"/json_get", { nova_request_app_main_controller, json_get}, #{methods => [get]}},
              {"/session/:session", {nova_request_app_main_controller, session}, #{methods => [get]}},
              {"/ws/:ws", nova_request_ws, #{protocol => ws}}
             ]
  },

  #{prefix => "/json_binding",
    security => false,
    routes => [{"/", {nova_request_app_main_controller, all}, #{methods => [get]}},
               {"/:json", { nova_request_app_main_controller, json_get_binding}, #{methods => [get]}}
              ]
    },

  #{prefix => "/secure",
    security => {nova_request_auth, auth},
    routes => [{"/:secure", {nova_request_app_main_controller, secure}, #{methods => [get]}},
               {"/apanws/:ws", nova_request_ws, #{protocol => ws}}]
  }].