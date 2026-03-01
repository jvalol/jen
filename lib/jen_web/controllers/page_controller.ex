defmodule JenWeb.PageController do
  use JenWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
