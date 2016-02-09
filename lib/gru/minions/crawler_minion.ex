defmodule GRU.CrawlerMinion do
  use GenServer

  def check(minion) do
    GenServer.call(minion, :check)
  end

  ##
  # GenServer API
  ##

  def start_link(url, terms) do
    HTTPoison.start
    {:ok, pid} = GenServer.start_link(__MODULE__, %{url: url, terms: terms})
    :timer.apply_interval(10_000, __MODULE__, :check, [pid])
    {:ok, pid}
  end

  def handle_call(:check, _from, state) do
    require Logger
    Logger.warn "Checking #{inspect state.url} for #{inspect state.terms}"

    %{body: body} = HTTPoison.get!(state.url)
    result = Enum.filter(state.terms, fn(term) -> body =~ term end)
    {:reply, result, state}
  end
end
