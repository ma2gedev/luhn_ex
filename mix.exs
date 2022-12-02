defmodule Luhn.Mixfile do
  use Mix.Project

  def project do
    [
      app: :luhn60,
      version: "1.3.12",
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      description: "Luhn algorithm in Elixir",
      package: [
        maintainers: ["Takayuki Matsubara"],
        licenses: ["MIT"],
        links: %{
          "GitHub" => "https://github.com/ma2gedev/luhn_ex",
          "Fork" => "https://github.com/devstopfix/luhn_ex"
        }
      ],
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      deps: deps()
    ]
  end

  def application do
    [applications: [:logger], extra_applications: [:propcheck]]
  end

  defp deps do
    [
      {:excoveralls, "~> 0.3", only: :dev},
      {:power_assert, "~> 0.2.1", only: :test},
      {:ex_doc, "~> 0.22.0", only: :dev, runtime: false},
      {:benchfella, "~> 0.3", only: :bench},
      {:propcheck, "~> 1.4", only: [:test, :dev]}
    ]
  end

  defp elixirc_paths(:test), do: ["test/helpers"] ++ elixirc_paths(:prod)
  defp elixirc_paths(_), do: ["lib"]
end
