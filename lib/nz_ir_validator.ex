defmodule NzIrValidator do
  @moduledoc """
  Documentation for NzIrValidator.
  """

  @length 8
  @primary_weighting [ 3, 2, 7, 6, 5, 4, 3, 2 ]
  @secondary_weighting [ 7, 4, 3, 2, 5, 2, 7, 6 ]
  @modulus 11

  @doc """
  Validate the provided IR number.

  ## Examples

    iex> NzIrValidator.is_valid?(49091850)
    {:ok, true}

    iex> NzIrValidator.is_valid?(9125568)
    {:error, false}

  """
  @spec is_valid?( integer ) :: { :ok, true } | { :error, false }
  def is_valid?( ird_number ) when not ird_number in 10_000_000..150_000_000, do: { :error, false }
  def is_valid?( ird_number ) do
    as_list = Integer.digits( ird_number )
    base    = Enum.drop( as_list, -1 ) |> Integer.undigits
    check   = List.last( as_list )

    base |> pad |> as_integer_list |> apply_algorithm( @primary_weighting, check )
  end

  # Calls helper functions to determine the validity of an IR number
  @spec apply_algorithm( list( integer ), list( integer ), integer ) :: { :ok, true } | { :error, false }
  defp apply_algorithm( list, weighting, check ) do
    list |> apply_weighting( weighting ) |> Enum.sum |> rem( @modulus) |> compare_against_check_digit( check, list )
  end

  # Pads an IR number with leading zeroes if necessary.
  # The required number of digits is specified by @length
  @spec pad( integer ) :: String.t
  defp pad( base ) do
    Integer.to_string( base ) |> String.pad_leading( @length, "0" )
  end

  # Converts an IR number from a String into an integer list.
  @spec as_integer_list( String.t ) :: list( integer )
  defp as_integer_list( padded ) do
    String.split( padded, "", trim: true ) |> Enum.map( fn(x) -> String.to_integer(x) end )
  end

  # Multiply each integer in the list with its corresponding weighting, as
  # specified in @primary_weighting and @secondary_weighting.
  @spec apply_weighting( list( integer ), list( integer ) ) :: list( integer )
  defp apply_weighting( list, weighting ) do
    Enum.zip( list, weighting ) |> Enum.reduce( [], fn(x, acc) -> acc ++ [elem(x, 0) * elem(x, 1)] end )
  end

  # Compare the remainder against the check digit.
  # Re-apply the validation algorithm (apply_algorithm()) if necesssary
  @spec compare_against_check_digit( list( integer), integer, integer ) :: { :ok, true } | { :error, false }
  defp compare_against_check_digit( remainder, _check, _list ) when remainder == 0, do: { :ok, true }
  defp compare_against_check_digit( remainder, check, _list ) when @modulus - remainder == check, do: { :ok, true }
  defp compare_against_check_digit( remainder, check, list ) when @modulus - remainder == 10, do: apply_algorithm( list, @secondary_weighting, check )
  defp compare_against_check_digit( _remainder, _check, _list ), do: { :error, false }
end
