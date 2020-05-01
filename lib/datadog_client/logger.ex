defmodule DatadogClient.Logger do
  @behaviour :gen_event
  require Record

  def init(_) do
    {:ok, %{}}
  end

  def handle_event({level, _group_leader, {Logger, msg, _timestamp, metadata}}, state) do
    try do
      DatadogClient.DatadogApi.log(msg, status: level, "logger.thread_name": metadata[:pid])
    rescue
      # the httppoison application isn't started yet
      _ -> IO.puts(msg)
    end
    {:ok, state}
  end

end
