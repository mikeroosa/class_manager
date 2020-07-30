defmodule ClassManagerWeb.HomeLive do
  use ClassManagerWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, query: "", results: %{})
    {:ok, socket}
  end
end
