defmodule NzIrValidatorTest do
  use ExUnit.Case
  doctest NzIrValidator

  test "identifies valid ir number 49091850" do
    assert NzIrValidator.is_valid?(49091850) == {:ok, true}
  end

  test "identifies valid ir number 35901981" do
    assert NzIrValidator.is_valid?(35901981) == {:ok, true}
  end

  test "identifies valid ir number 49098576" do
    assert NzIrValidator.is_valid?(49098576) == {:ok, true}
  end

  test "identifies valid ir number 136410132" do
    assert NzIrValidator.is_valid?(136410132) == {:ok, true}
  end

  test "identifies invalid ir number 136410133" do
    assert NzIrValidator.is_valid?(136410133) == {:error, false}
  end

  test "identifies invalid ir number 9125568" do
    assert NzIrValidator.is_valid?(9125568) == {:error, false}
  end
end
