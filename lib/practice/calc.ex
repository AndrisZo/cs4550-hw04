import Enum

defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> tagtokens
    |> postfix
    |> evalpostfix([])


    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end

  def evalpostfix(input, stack) do
    cond do
      empty?(input) -> hd(stack)
      is_number(hd(input)) ->
        evalpostfix(tl(input), [hd(input) | stack])
      true -> evalpostfix(tl(input), handleoperation(hd(input), stack))
    end
  end

  def handleoperation(operation, stack) do
    case operation do
      "+" ->
        newhead = hd(tl(stack)) + hd(stack)
        [newhead | tl(tl(stack))]
      "-" ->
        newhead = hd(tl(stack)) - hd(stack)
        [newhead | tl(tl(stack))]
      "*" ->
        newhead = hd(tl(stack)) * hd(stack)
        [newhead | tl(tl(stack))]
      "/" ->
        newhead = hd(tl(stack)) / hd(stack)
        [newhead | tl(tl(stack))]
    end
  end

  def postfix(list) do
    postfix(list, [], [])
  end

  # List of {:number, num} or {:operation, string}, List, List
  def postfix(input, stack, output) do
    cond do
      empty?(input) ->
        finishpostfix(stack, output)
      elem(hd(input), 0) == :number ->
        postfix(tl(input), stack, output ++ [elem(hd(input), 1)])
      elem(hd(input), 0) == :operation ->
        {newstack, newoutput} = processoperation(elem(hd(input), 1), stack, output)
        postfix(tl(input), newstack, newoutput)
    end
  end

  # String, List, List -> {List, List}
  def processoperation(operator, stack, output) do
  priority = %{"+" => 1, "-" => 1, "*" => 2,"/" => 2}
    cond do
      empty?(stack) -> {[operator], output}
      priority[operator] > priority[hd(stack)] ->
        {[operator | stack], output}
      priority[hd(stack)] == priority[operator] ->
        {[operator | tl(stack)], putatend(output, hd(stack))}
      priority[operator] < priority[hd(stack)] ->
        processoperation(operator, tl(stack), putatend(output, hd(stack)))
    end
  end

  def finishpostfix(stack, output) do
    output ++ stack
  end

  def putatend(list, thing) do
    list ++ [thing]
  end


  def tagtokens(given) do
    Enum.map(given, &tagtoken/1)
  end

  def tagtoken(token) do
    cond do
      Enum.member?(["+", "-", "*", "/"], token) ->
        {:operation, token}
      is_token_int?(token) ->
        {:number, String.to_float(token <> ".0")}
      is_token_float?(token) -> (
        {:number, String.to_float(token)}
      )
      true -> :error
    end
  end

  def is_token_int?(token) do
    case Integer.parse(token) do
      {_num, ""} -> true
      _ -> false
    end
  end

  def is_token_float?(token) do
    case Float.parse(token) do
      {_num, ""} -> true
      _ -> false
    end
  end




end
