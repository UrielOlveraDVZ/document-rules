defmodule DocumentRules.MixProject do
  use Mix.Project

  def project do
    [
      app: :document_rules,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :con_cache, :httpoison]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:decimal, "~> 1.0"},
      {:con_cache, "0.11.0"},
      {:saxy, "~> 1.4"},
      {:sax_map, "~> 1.0"},
      {:xml_json, "~> 0.3.0"},
      {:xlsxir, "~> 1.6.4"},
      {:httpoison, "~> 2.0"},
      {:jason, "~> 1.2"}
    ]
  end
end
