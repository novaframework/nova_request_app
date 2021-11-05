-module(nova_request_app_SUITE).

-compile(export_all).

-include_lib("common_test/include/ct.hrl").

-define(BASEPATH, <<"http://localhost:8080/">>).

%%--------------------------------------------------------------------
%% @spec suite() -> Info
%% Info = [tuple()]
%% @end
%%--------------------------------------------------------------------
suite() ->
    [{timetrap,{seconds,30}}].

%%--------------------------------------------------------------------
%% @spec init_per_suite(Config0) ->
%%     Config1 | {skip,Reason} | {skip_and_save,Reason,Config1}
%% Config0 = Config1 = [tuple()]
%% Reason = term()
%% @end
%%--------------------------------------------------------------------
init_per_suite(_Config) ->
    [].

%%--------------------------------------------------------------------
%% @spec end_per_suite(Config0) -> term() | {save_config,Config1}
%% Config0 = Config1 = [tuple()]
%% @end
%%--------------------------------------------------------------------
end_per_suite(Config) ->
    ok.

%%--------------------------------------------------------------------
%% @spec init_per_group(GroupName, Config0) ->
%%               Config1 | {skip,Reason} | {skip_and_save,Reason,Config1}
%% GroupName = atom()
%% Config0 = Config1 = [tuple()]
%% Reason = term()
%% @end
%%--------------------------------------------------------------------
init_per_group(_GroupName, Config) ->
    Config.

%%--------------------------------------------------------------------
%% @spec end_per_group(GroupName, Config0) ->
%%               term() | {save_config,Config1}
%% GroupName = atom()
%% Config0 = Config1 = [tuple()]
%% @end
%%--------------------------------------------------------------------
end_per_group(_GroupName, _Config) ->
    ok.

%%--------------------------------------------------------------------
%% @spec init_per_testcase(TestCase, Config0) ->
%%               Config1 | {skip,Reason} | {skip_and_save,Reason,Config1}
%% TestCase = atom()
%% Config0 = Config1 = [tuple()]
%% Reason = term()
%% @end
%%--------------------------------------------------------------------
init_per_testcase(_TestCase, Config) ->
    Config.

%%--------------------------------------------------------------------
%% @spec end_per_testcase(TestCase, Config0) ->
%%               term() | {save_config,Config1} | {fail,Reason}
%% TestCase = atom()
%% Config0 = Config1 = [tuple()]
%% Reason = term()
%% @end
%%--------------------------------------------------------------------
end_per_testcase(_TestCase, _Config) ->
    ok.

%%--------------------------------------------------------------------
%% @spec groups() -> [Group]
%% Group = {GroupName,Properties,GroupsAndTestCases}
%% GroupName = atom()
%% Properties = [parallel | sequence | Shuffle | {RepeatType,N}]
%% GroupsAndTestCases = [Group | {group,GroupName} | TestCase]
%% TestCase = atom()
%% Shuffle = shuffle | {shuffle,{integer(),integer(),integer()}}
%% RepeatType = repeat | repeat_until_all_ok | repeat_until_all_fail |
%%              repeat_until_any_ok | repeat_until_any_fail
%% N = integer() | forever
%% @end
%%--------------------------------------------------------------------
groups() ->
    [].

%%--------------------------------------------------------------------
%% @spec all() -> GroupsAndTestCases | {skip,Reason}
%% GroupsAndTestCases = [{group,GroupName} | TestCase]
%% GroupName = atom()
%% TestCase = atom()
%% Reason = term()
%% @end
%%--------------------------------------------------------------------
all() ->
    [get_qs,
     post_params,
     post_json,
     get_json].
%%--------------------------------------------------------------------
%% @spec TestCase(Config0) ->
%%               ok | exit() | {skip,Reason} | {comment,Comment} |
%%               {save_config,Config1} | {skip_and_save,Reason,Config1}
%% Config0 = Config1 = [tuple()]
%% Reason = term()
%% Comment = term()
%% @end
%%--------------------------------------------------------------------

get_qs(_) ->
    Path = [?BASEPATH, <<"get_qs?ordered_by=name">>],
    #{status := {200, _}, body := RespBody} = shttpc:get(Path, opts()),
    #{<<"oredered_by">> := <<"name">>} = json:decode(RespBody, [maps]).

post_params(_) ->
    Path = [?BASEPATH, <<"post_params">>],
    Params = <<"field1=value1&field2=value2">>,
    #{status := {200, _}, body := RespBody} = shttpc:post(Path, Params, opts(form)),
    #{<<"field1">> := <<"value1">>,
      <<"field2">> := <<"value2">>} = json:decode(RespBody, [maps]).

post_json(_) ->
    Path = [?BASEPATH, <<"json_post">>],
    Json = #{<<"field1">> => <<"value1">>,
             <<"field2">> => <<"value2">>},
    #{status := {200, _}, body := RespBody} = shttpc:post(Path, encode(Json), opts(json_post)),
    #{<<"field1">> := <<"value1">>,
      <<"field2">> := <<"value2">>} = json:decode(RespBody, [maps]).

get_json(_) ->
    Path = [?BASEPATH, <<"json_get">>],
    #{status := {200, _}, body := RespBody} = shttpc:get(Path, opts(json_get)),
    #{<<"test">> := <<"json">>} = json:decode(RespBody, [maps]).

opts() ->
    opts(undefined).
opts(undefined) ->
    #{headers => #{}, close => true};
opts(form) ->
    #{headers => #{'Content-Type' => <<"application/x-www-form-urlencoded">>}, close => true};
opts(json_get) ->
    #{headers => #{'Accept' => <<"application/json">>}, close => true};
opts(json_post) ->
    #{headers => #{'Content-Type' => <<"application/json">>}, close => true}.



encode(Json) ->
    json:encode(Json, [maps, binary]).