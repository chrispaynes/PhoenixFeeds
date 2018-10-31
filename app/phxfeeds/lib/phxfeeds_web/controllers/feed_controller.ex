defmodule PhxfeedsWeb.FeedController do
  use PhxfeedsWeb, :controller

  alias Phxfeeds.Feeds
  alias Phxfeeds.Feeds.Feed

  action_fallback PhxfeedsWeb.FallbackController

  def index(conn, _params) do
    feeds = Feeds.list_feeds()
    render(conn, "index.json", feeds: feeds)
  end

  def create(conn, %{"feed" => feed_params}) do
    with {:ok, %Feed{} = feed} <- Feeds.create_feed(feed_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.feed_path(conn, :show, feed))
      |> render("show.json", feed: feed)
    end
  end

  def show(conn, %{"id" => id}) do
    feed = Feeds.get_feed!(id)
    render(conn, "show.json", feed: feed)
  end

  def update(conn, %{"id" => id, "feed" => feed_params}) do
    feed = Feeds.get_feed!(id)

    with {:ok, %Feed{} = feed} <- Feeds.update_feed(feed, feed_params) do
      render(conn, "show.json", feed: feed)
    end
  end

  def delete(conn, %{"id" => id}) do
    feed = Feeds.get_feed!(id)

    with {:ok, %Feed{}} <- Feeds.delete_feed(feed) do
      send_resp(conn, :no_content, "")
    end
  end
end
