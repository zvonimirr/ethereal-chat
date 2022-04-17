defmodule EtherealChatWeb.ChatChannel do
  use EtherealChatWeb, :channel

  @impl true
  def join("main", _payload, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_in("get-info", _payload, socket) do
    info = %{name: get_random_name(), color: get_random_color()}
    broadcast!(socket, "joined", info)
    {:reply, {:ok, info}, socket}
  end

  @impl true
  def handle_in("send-message", payload, socket) do
    broadcast!(socket, "message", payload)
    {:noreply, socket}
  end

  # @impl true
  # def handle_out ("message", from, socket) do
  # end

  # # Channels can be used in a request/response fashion
  # # by sending replies to requests from the client
  # @impl true
  # def handle_in("ping", payload, socket) do
  #   {:reply, {:ok, payload}, socket}
  # end

  # # It is also common to receive messages from the client and
  # # broadcast to everyone in the current topic (chat:lobby).
  # @impl true
  # def handle_in("shout", payload, socket) do
  #   broadcast(socket, "shout", payload)
  #   {:noreply, socket}
  # end
  defp get_random_name do
    MnemonicSlugs.generate_slug()
    |> String.split("-")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end

  defp get_random_color do
    RandomColour.generate()
  end
end
