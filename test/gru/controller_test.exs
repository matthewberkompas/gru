defmodule GRU.ControllerTest do
  use ExUnit.Case

  import GRU.Controller

  test "help" do
    expected =
      """
      minion crawl <website> for <term>
      """

    assert command(["minion", "help"]) == expected
  end

  test "crawl" do
    assert command(["minion", "crawl", "website", "for", "term"]) == "Crawler has been started"
  end

  test "default" do
    assert command([]) == "A thousand pardons, most gracious master, but I didn't understand you just now."
  end
end
