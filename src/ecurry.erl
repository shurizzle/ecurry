-module(ecurry).
-export([curry/1, partial/2]).

curry(Function) when is_function(Function) ->
  {arity, Arity} = erlang:fun_info(Function, arity),
  curry(Function, Arity, []).

curry(Fun, 0, Args) ->
  apply(Fun, lists:reverse(Args));
curry(Fun, Arity, Args) ->
  fun (Arg) -> curry(Fun, Arity - 1, [Arg | Args]) end.

partial(Fun, Args) when is_function(Fun) andalso is_list(Args) ->
  {arity, Arity} = erlang:fun_info(Fun, arity),

  ANames = string:join(["X" ++ integer_to_list(X) || X <- lists:seq(1, Arity - length(Args))], ", "),

  {ok, Tokens, _} = erl_scan:string("fun (" ++ ANames ++ ") -> apply(Fun, Args ++ [" ++ ANames ++ "]) end."),
  {ok, [Forms]} = erl_parse:parse_exprs(Tokens),
  B1 = erl_eval:add_binding('Fun', Fun, erl_eval:new_bindings()),
  B2 = erl_eval:add_binding('Args', Args, B1),
  {value, PartialFun, _} = erl_eval:expr(Forms, B2),

  PartialFun.
