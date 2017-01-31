defmodule Luhn.Mixfile do
  use Mix.Project

  def project do
    [app: :luhn,
     version: "0.3.1",
     elixir: "~> 1.0",
     description: "Luhn algorithm in Elixir",
     package: [
       maintainers: ["Takayuki Matsubara"],
       licenses: ["MIT"],
       links: %{"GitHub" => "https://github.com/ma2gedev/luhn_ex"}
     ],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     test_coverage: [tool: ExCoveralls],
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:excoveralls, "~> 0.3", only: :dev},
     {:benchfella, "~> 0.3", only: :bench}]
  end
end
