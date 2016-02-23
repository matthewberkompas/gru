defmodule GRU.CrawlerSupervisor do
  use Supervisor

  alias GRU.CrawlerMinion

  def crawl(url, terms) do
    Supervisor.start_child(__MODULE__, [url, terms])
  end

  ###
  # Supervisor API
  ###

  def start_link do
    Supervisor.start_link(__MODULE__, [], [name: __MODULE__])
  end

  def init(_) do
    children = [
      worker(CrawlerMinion, [], restart: :transient)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
