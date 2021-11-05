# nova_request_app

This repo shows how to use nova_request_plugin.

```erlang
         {plugins, [
                    {pre_request, nova_request_plugin, #{decode_json_body => true,
                                                         read_urlencoded_body => true,
                                                         parse_qs => true}}
                   ]}
```

In config/dev_sys.config.src we have added a pre_request plugin, in this case the nova_request_plugin. It is a plugin to handle different plugin data.
We have added some options to it, that it should decode json, in this case when content-type is application/json it will decode json to a map.

Code examples can be find in the controller. It is also some tests in the test suite.
