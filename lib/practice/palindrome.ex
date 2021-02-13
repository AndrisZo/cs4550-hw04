defmodule Practice.Palindrome do
  def palindrome?(x) do
    x
    |> String.downcase(:default)
    |> String.split("")
    |> palindromeList?
  end

  def palindromeList?(list) do
    equalLists?(list, Enum.reverse(list))
  end

  def equalLists?(list1, list2) do
    list1 == list2
  end
end
