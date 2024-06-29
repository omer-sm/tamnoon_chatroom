defmodule TamnoonChatroom.Components.MessageBox do
  @behaviour Tamnoon.Component

  @impl true
  def heex do
    ~s"""
    <div>
      <h4> <%= h.(@user_name) %> </h4>
      <p> <%= h.(@content) %> </p>
    </div>
    """
  end
end
