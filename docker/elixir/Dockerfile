FROM elixir:1.7.3

RUN apt-get update

EXPOSE 4000

WORKDIR /phxfeeds

RUN mix local.hex --force \
    && mix local.rebar --force \
    && mix archive.install hex phx_new 1.4.0-rc.2 --force

COPY ./app/phxfeeds/ .

RUN mix deps.get \
    && mix ecto.create

RUN mix deps.get

ENTRYPOINT mix phx.server

CMD foreground
