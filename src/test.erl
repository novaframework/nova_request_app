-module(test).

-export([stacktrace_defined/0]).


-ifndef(USE_STACKTRACES).
stacktrace_defined() ->
    no.
-else.
stacktrace_defined() ->
    yes.
-endif.