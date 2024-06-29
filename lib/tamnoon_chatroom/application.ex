defmodule TamnoonChatroom.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Tamnoon, [[initial_state: %{msgs: [], name: "", curr_msg: ""},
      methods_module: TamnoonChatroom.Methods]]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TamnoonChatroom.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
