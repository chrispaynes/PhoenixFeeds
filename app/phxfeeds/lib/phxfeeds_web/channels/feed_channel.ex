defmodule PhxfeedsWeb.FeedChannel do
  use PhxfeedsWeb, :channel

  def join("feed", payload, socket) do
    {:ok, socket}
    #if authorized?(payload) do
    #  {:ok, socket}
    #else
    #  {:error, %{reason: "unauthorized"}}
    #end
  end

  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end

  def create_broadcast(feed) do
    payload = %{
        "id" => to_string(feed.id),
        "title" => feed.title,
        "description" => feed.description
    }

    Phxfeeds.Endpoint.broadcast("feeds", "app/FeedsPage/HAS_NEW_FEEDS", payload)
  end 

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (feed:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
