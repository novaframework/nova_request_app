-module(nova_request_app_fallback_controller).
-export([
    resolve/2
]).

resolve(_Req, {error, bad_data}) ->
  {status, 400}.