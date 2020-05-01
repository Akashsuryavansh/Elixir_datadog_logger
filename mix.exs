defmodule DatadogClient.MixProject do
  use Mix.Project

  def project do
    [
      app: :datadog_client,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {DatadogClient.Application, []},
      applications: [:httpoison],
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.6"},
      {:jason, "~> 1.2"}
    ]
  end
end
