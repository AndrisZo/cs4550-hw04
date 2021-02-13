defmodule PracticeWeb.PageController do
  use PracticeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def double(conn, %{"x" => x}) do
    {x, _} = Integer.parse(x)
    y = Practice.double(x)
    render conn, "double.html", x: x, y: y
  end

  def calc(conn, %{"expr" => expr}) do
    y = Practice.calc(expr)
    render conn, "calc.html", expr: expr, y: y
  end

  def factor(conn, %{"x" => x}) do
    y = Practice.factor(x)
    render conn, "factor.html", x: x, y: fixbads(inspect(y))
  end

  def palindrome(conn, %{"word" => word}) do
    answer = give_yn(Practice.palindrome?(word))
    render conn, "palindrome.html", word: word, answer: answer
  end

  def fixbads(str) do
    case str do
      "'\\a'" -> "[7]"
      "'\\v'" -> "[11]"
      "'\\r'" -> "[13]"
      "[]" -> "None"
      _ -> str
    end
  end

  def give_yn(bool) do
    if bool do
      "Yes"
    else
      "No"
    end
  end
end
