defmodule DatadogClient.DatadogApi do
  # use Tesla

  # for eu
  @url "https://http-intake.logs.datadoghq.eu/v1/input"
  # for us
  # @url "https://http-intake.logs.datadoghq.com/v1/input"
  @headers [
    {"Content-Type", "application/json"},
    {"DD-API-KEY", Application.get_env(:datadog_client, :api_key)}
  ]

  @default_params %{
    ddsource: Application.get_env(:datadog_client, :source),
    service: Application.get_env(:datadog_client, :service),
    host: Application.get_env(:datadog_client, :host),
    "logger.name": Application.get_env(:datadog_client, :logger_name)
  }

  @doc ~S"""
  params can be anything that datadog accepts:
  log("message", ddtags: "tag", ddsource: "my-source", service:"my-service", hostname: "w323c.example.com")

  params:
  *host*	The name of the originating host as defined in metrics. We automatically retrieve corresponding host
          tags from the matching host in Datadog and apply them to your logs. The Agent sets this value automatically.
  *source*	This corresponds to the integration name: the technology from which the log originated. When it
            matches an integration name, Datadog automatically installs the corresponding parsers and facets.
            For example: nginx, postgresql, etc.
  *status*	This corresponds to the level/severity of a log. It is used to define patterns and has a dedicated
            layout in the Datadog Log UI.
  *service*	The name of the application or service generating the log events. It is used to switch from Logs to APM,
            so make sure you define the same value when you use both products.
  *message*	By default, Datadog ingests the value of the message attribute as the body of the log entry. That value
            is then highlighted and displayed in the Logstream, where it is indexed for full text search.
  *logger.name* Name of the logger
  *logger.thread_name*  Name of the current thread
  *error.stack* Actual stack trace
  *error.message* Error message contained in the stack trace
  *error.kind*  The type or “kind” of an error (i.e “Exception”, “OSError”, …)
  """
  def log(msg, params \\ []) do
    if !is_binary(msg) do
      {:ok, msg} = Jason.encode(msg)
      log_str(msg, params)
    else
      log_str(msg, params)
    end
  end

  def log_str(msg, params) do
    params =
      @default_params
      |> Map.merge(Map.new(params))
      |> Map.put_new(:"logger.thread_name", inspect(self()))

      IO.puts @url <> to_query_string(params)
      IO.puts msg

    {:ok, _res = %HTTPoison.Response{status_code: 200}} =
      HTTPoison.post(@url <> to_query_string(params), msg, @headers)
  end

  def info(msg, params \\ []) do
    log(
      msg,
      params
      |> Map.new()
      |> Map.put(:status, "info")
    )
  end

  def error(msg, params \\ []) do
    log(
      msg,
      params
      |> Map.new()
      |> Map.put(:status, "error")
    )
  end

  def debug(msg, params \\ []) do
    log(
      msg,
      params
      |> Map.new()
      |> Map.put(:status, "debug")
    )
  end

  def critical(msg, params \\ []) do
    log(
      msg,
      params
      |> Map.new()
      |> Map.put(:status, "critical")
    )
  end

  defp to_query_string(params) when params == %{}, do: ""

  defp to_query_string(params) do
    # params =
    #   params
    #   |> Map.to_list()
    #   |> Enum.map(fn {key, value} ->
    #     to_string(key) <> "=" <> to_string(value)
    #   end)
    #   |> Enum.join("&")
    #   |>

    "?" <> URI.encode_query(params)
  end
end
