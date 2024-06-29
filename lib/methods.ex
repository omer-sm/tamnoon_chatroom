defmodule TamnoonChatroom.Methods do
  use Tamnoon.Methods

  defmethod :send_msg do
    {msg, new_state} = Map.get_and_update(state, :curr_msg, &({&1, ""}))
    msg = Tamnoon.Compiler.render_component(TamnoonChatroom.Components.MessageBox, %{
      user_name: state[:name],
      content: msg
    }, true)
    {%{pub: :ok}, new_state} = pub(%{
      "channel" => "clients",
      "action" =>
      %{"method" => "add_msg",
        "msg" => msg}
    }, new_state)
    {%{"curr_msg" => ""}, new_state}
  end

  defmethod :add_msg do
    msg = req["msg"]
    {_old_msgs, new_state} = Map.get_and_update(state, :msgs, &({&1, [msg | Enum.take(&1, 4)]}))
    msgs_ret = Enum.reduce(new_state[:msgs], fn x, acc ->
      x <> acc
    end)
    {%{"msgs" => msgs_ret}, new_state}
  end
end
