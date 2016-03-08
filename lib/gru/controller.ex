defmodule GRU.Controller do
  def command(["minion", "help"]) do
    """
    minion crawl <website> for <term>
    """
  end

  def command(["minion", "crawl", website, "for", term]) do
    GRU.CrawlerSupervisor.crawl(website, [term])
    "Crawler has been started"
  end

  def command(_) do
    "A thousand pardons, most gracious master, but I didn't understand you just now."
  end
end
