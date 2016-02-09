defmodule GRU do
  use Application

  alias GRU.CrawlerMinion, as: Crawler

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      # worker(Gru.Worker, [arg1, arg2, arg3]),
      worker(Crawler, ["https://www.humblebundle.com", ["XCOM 2"]], id: :humble),
      worker(Crawler, ["https://www.apple.com", ["Apple Car"]], id: :apple)
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gru.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
