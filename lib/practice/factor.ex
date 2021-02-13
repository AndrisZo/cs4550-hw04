defmodule Practice.Factor do
  def factor(x) do
    x
    |> convertToInt
    |> listFactors(2, [])
    |> Enum.reverse
  end

  def convertToInt(x) do
    cond do
      is_number(x) -> x
      Practice.Calc.is_token_int?(x) ->
        String.to_integer(x)
      true -> :error
    end
  end

  def listFactors(number, tryfactor, factors) do
    cond do
      number == :error -> "Must provide an integer to factor"
      number == 1 -> factors
      tryfactor >= number -> [number | factors]
      rem(number, tryfactor) == 0 ->
        listFactors(div(number, tryfactor), tryfactor, [tryfactor | factors])
      true ->
        listFactors(number, tryfactor + 1, factors)
    end
  end

end
