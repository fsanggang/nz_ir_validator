# NzBankAccountValidator

[![Build Status](https://travis-ci.org/fsanggang/nz_ir_validator.svg?branch=master)](https://github.com/fsanggang/nz_ir_validator)
[![Hex.pm](https://img.shields.io/hexpm/v/nz_ir_validator.svg)](https://hex.pm/packages/nz_ir_validator)


Validator for NZ bank accounts.

## Examples

```elixir
$ iex -S mix
> NzIrValidator.is_valid?(49091850)
{:ok, true}

iex> NzIrValidator.is_valid?(9125568)
{:error, false}
```


## Installation

Add `nz_ir_validator` to your list of dependencies in mix.exs:

```elixir
def deps do
  [
    {:nz_ir_validator, "~> 1.0.0"}
  ]
end
```

Don’t forget to update your dependencies.

```
$ mix deps.get
```

## Links

Implementation is based off https://www.ird.govt.nz/resources/d/8/d8e49dce-1bda-4875-8acf-9ebf908c6e17/rwt-nrwt-spec-2014.pdf.