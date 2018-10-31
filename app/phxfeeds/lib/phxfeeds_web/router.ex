defmodule PhxfeedsWeb.Router do
  use PhxfeedsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PhxfeedsWeb do
    pipe_through :api
    resources "/feeds", FeedController, except: [:new, :edit]                                                                         
  end
end
