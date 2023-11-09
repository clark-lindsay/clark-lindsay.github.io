defmodule Clark.MixProject do
  use Mix.Project

  def project do
    [
      app: :clark,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      compilers: [:temple] ++ Mix.compilers(),
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :telemetry]
    ]
  end

  def aliases do
    [
      build: ["tableau.build", "tailwind default --minify"]
    ]
  end

  defp deps do
    [
      {:tableau, "~> 0.11"},
      {:temple, "~> 0.12"},
      {:tailwind, "~> 0.2", runtime: Mix.env() == :dev}
    ]
  end
end
