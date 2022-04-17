defmodule EtherealChatWeb.PageController do
  use EtherealChatWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
