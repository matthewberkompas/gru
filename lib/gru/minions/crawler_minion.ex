defmodule GRU.CrawlerMinion do
  use GenServer

  alias GRU.Slack

  def check(minion) do
    GenServer.call(minion, :check)
  end

  ##
  # GenServer API
  ##
  def start_link(url, terms) do
    {:ok, pid} = GenServer.start_link(__MODULE__, %{url: url, terms: terms})
    :timer.apply_interval(10_000, __MODULE__, :check, [pid])
    {:ok, pid}
  end

  def handle_call(:check, _from, state) do
    %{body: body} = HTTPoison.get!(state.url)
    present_terms = Enum.filter(state.terms, fn(term) -> body =~ term end)

    if length(present_terms) > 0 do
      Slack.webhook("I have detected \"#{Enum.join(present_terms, ", ")}\" on #{state.url}")
    end

    {:reply, present_terms, state}
  end
end
