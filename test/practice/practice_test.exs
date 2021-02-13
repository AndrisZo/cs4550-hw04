defmodule Practice.PracticeTest do
  use ExUnit.Case
  import Practice.Calc
  import Practice.Factor
  import Practice.Palindrome

  #test "double some numbers" do
    #assert double(4) == 8
    #assert double(3.5) == 7.0
    #assert double(21) == 42
    #assert double(0) == 0
  #end

  test "factor some numbers" do
    assert factor(5) == [5]
    assert factor(13) == [13]
    assert factor(8) == [2,2,2]
    assert factor(12) == [2,2,3]
    assert factor(226037113) == [3449, 65537]
    assert factor(1575) == [3,3,5,5,7]
  end

  test "test listFactors" do
    assert listFactors(:error, [], []) == "Must provide an integer to factor"
    assert listFactors(1, 2, []) == []
    assert listFactors(1, 2, []) == []
    assert listFactors(5, 2, []) == [5]
    assert listFactors(10, 2, []) == [5, 2]
    assert listFactors(9, 2, []) == [3, 3]
    assert listFactors(81, 2, []) == [3, 3, 3, 3]
  end

  test "test convertToInt" do
    assert convertToInt("5") == 5
    assert convertToInt("-5") == -5
  end

  test "evaluate some expressions" do
    assert calc("5") == 5
    assert calc("5 + 1") == 6
    assert calc("5 * 3") == 15
    assert calc("10 / 2") == 5
    assert calc("10 - 2") == 8
    assert calc("5 * 3 + 8") == 23
    assert calc("8 + 5 * 3") == 23
  end

  test "test evalpostfix" do
    assert evalpostfix([], [5]) == 5
    assert evalpostfix([-1], []) == -1
    assert evalpostfix([1, 2, "+"], []) == 3
  end

  test "test tagtokens" do
    assert tagtokens(["5"]) == [{:number, 5}]
    assert tagtokens(["5.0"]) == [{:number, 5.0}]
    assert tagtokens(["+"]) == [{:operation, "+"}]
    assert tagtokens(["-"]) == [{:operation, "-"}]
    assert tagtokens(["*"]) == [{:operation, "*"}]
    assert tagtokens(["/"]) == [{:operation, "/"}]
    assert tagtokens(["5", "+", "9.0", "-", "2.1"]) ==  [{:number, 5}, {:operation, "+"}, {:number, 9.0},  {:operation, "-"}, {:number, 2.1}]
  end

  test "test tagtoken" do
    assert tagtoken("5") == {:number, 5}
    assert tagtoken("5.0") == {:number, 5.0}
    assert tagtoken("+") == {:operation, "+"}
    assert tagtoken("-") == {:operation, "-"}
    assert tagtoken("*") == {:operation, "*"}
    assert tagtoken("/") == {:operation, "/"}
  end

  test "test handle operation" do
    assert handleoperation("+", [3, 9]) == [12]
    assert handleoperation("-", [3, 9]) == [6]
    assert handleoperation("*", [3, 9]) == [27]
    assert handleoperation("/", [3, 9]) == [3.0]
  end

  test "test postfix" do
    assert postfix([{:number, 1}, {:operation, "+"}, {:number, 2}], [], []) == [1, 2, "+"]
    assert postfix([{:number, 5}, {:operation, "+"}, {:number, 10}, {:operation, "*"}, {:number, 3}], [], []) == [5, 10, 3, "*", "+"]
    assert postfix([{:number, 5}, {:operation, "*"}, {:number, 10}, {:operation, "+"}, {:number, 3}], [], []) == [5, 10, "*", 3, "+"]
  end

  test "test finishpostfix" do
    assert finishpostfix([1, 2], []) == [1, 2]
    assert finishpostfix([4, 5, 6], [1, 2, 3]) == [1, 2, 3, 4, 5, 6]
  end

  test "test putatend" do
    assert putatend([1, 2, 3], 4) == [1, 2, 3, 4]
  end

  test "test processoperation" do
    assert processoperation("+", [], [1]) == {["+"], [1]}
    assert processoperation("+", ["-"], [1]) == {["+"], [1, "-"]}
    assert processoperation("+", ["*"], [1]) == {["+"], [1, "*"]}
    assert processoperation("*", ["+"], [1]) == {["*", "+"], [1]}
  end


  test "test string splitting" do
    assert String.split("abcd", "") == ["", "a", "b", "c", "d", ""]
  end

  test "test palindromes" do
    assert palindrome?("Kayak") == true
    assert palindrome?("kayak") == true
    assert palindrome?("Not") == false
    assert palindrome?("giant not tnaig") == false
    assert palindrome?("Giant palindrome EmordnilaP tnaig") == true
  end
end
