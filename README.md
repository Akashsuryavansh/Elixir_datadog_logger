# DatadogClient

Alternative Datadog client POC for elixir

send some basic logs:

```

DatadogClient.DatadogApi.info(%{message: "data"})
DatadogClient.DatadogApi.info(%{
  message: "This is an example log message over HTTP!",
  http: %{
    status_code: 301,
    method: "POST",
    request_id: "1"
  },
  network: %{
    client: %{
      ip: "127.0.0.1",
      port: "80"
    },
    destination: %{
      ip: "10.0.0.1"
    }
  },
  duration: 2000,
  category: "test"
})
DatadogClient.DatadogApi.info("asd")
DatadogClient.DatadogApi.info("asd", ddtags: "tag1")
DatadogClient.DatadogApi.info("asd", ddtags: "tag1,tag2")
DatadogClient.DatadogApi.info("asd", asd: "asd")
DatadogClient.DatadogApi.info("asd", user: "user1")
DatadogClient.DatadogApi.info("asd", ddsource: "laptop")
DatadogClient.DatadogApi.info("asd", service: "something")
DatadogClient.DatadogApi.info("asd", service: "something", ddtags: "tag1")
DatadogClient.DatadogApi.info("asd", status: "error") # same as below
DatadogClient.DatadogApi.error("asd")
DatadogClient.DatadogApi.critical("asd")
DatadogClient.DatadogApi.error("asd")
DatadogClient.DatadogApi.debug("asd")
```

even more options:

```
DatadogClient.DatadogApi.info("asd", "logger.name": "test-logger.name")
DatadogClient.DatadogApi.info("asd", "logger.thread_name": "test-logger.thread_name")
DatadogClient.DatadogApi.info("asd", "error.stack": "test-error.stack")
DatadogClient.DatadogApi.info("asd", "error.message": "test-error.message")
DatadogClient.DatadogApi.info("asd", "error.kind": "test-error.kind")
```

with the custom elixir logger setup (see `config/config.exs`) you can also use:

```
Logger.error "asd"
Logger.info "asd"
Logger.debug "asd"
```

# Install

run `mix deps.get`

provide datadog API key in `config/config.exs` at `:datadog_client` / `:api_key`

# Run

if you can you want try any of this, uncomment them in `lib/datadog_client/application.ex` and run `mix run`
