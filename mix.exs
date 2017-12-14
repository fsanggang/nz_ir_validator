defmodule NzIrValidator.Mixfile do
  use Mix.Project

  @github_url "https://github.com/fsanggang/nz_ir_validator"

  def project do
    [
      app: :nz_ir_validator,
      version: "1.0.0",
      elixir: "~> 1.5",
      name: "NzIrValidator",
      description: "Validates NZ IR numbers",
      source_url: @github_url,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: [ "Fiona Sanggang" ],
      licenses: [ "MIT" ],
      links: %{ "Github" => @github_url }
    ]
  end
end
