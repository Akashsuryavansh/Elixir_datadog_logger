import Config

config :datadog_client,
  api_key: "",
  host: "some-server",
  # *host*	The name of the originating host as defined in metrics. We automatically retrieve corresponding host
  #         tags from the matching host in Datadog and apply them to your logs. The Agent sets this value automatically.
  source: "some-source",
  # *source*	This corresponds to the integration name: the technology from which the log originated. When it
  #           matches an integration name, Datadog automatically installs the corresponding parsers and facets.
  #           For example: nginx, postgresql, etc.
  service: "some-service",
  # *service*	The name of the application or service generating the log events. It is used to switch from Logs to APM,
  #           so make sure you define the same value when you use both products.
  logger_name: "custom-elixir-logger"

config :logger,
  handle_otp_reports: true,
  handle_sasl_reports: true,
  backends: [DatadogClient.Logger]
