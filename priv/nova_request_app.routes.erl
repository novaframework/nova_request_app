#{prefix => "",
  security => false,
  routes => [
            {"/get_qs", { nova_request_app_main_controller, get_qs}, #{methods => [get]}},
            {"/post_params", { nova_request_app_main_controller, post_params}, #{methods => [post]}},
            {"/json_post", { nova_request_app_main_controller, json_post}, #{methods => [post]}},
            {"/json_get", { nova_request_app_main_controller, json_get}, #{methods => [get]}},
            {"/json_get/:json", { nova_request_app_main_controller, json_get_binding}, #{methods => [get]}}
           ]
}.
