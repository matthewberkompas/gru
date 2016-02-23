defmodule GRU.Slack do
  @url Application.get_env(:gru, :slack_webhook_url)
  @titles Application.get_env(:gru, :titles)

  def webhook(message) do
    title = Enum.random(@titles)
    message = Poison.encode!(%{text: "[CrawlerMinion] #{title}, #{message}"})
    HTTPoison.post!(@url, message)
  end
end
