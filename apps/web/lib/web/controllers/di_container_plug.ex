defmodule Web.DIContainerPlug do
  @behaviour Plug

  def init(options) when is_map(options) do
    options
  end

  def call(conn, _options) do
    conn
  end
end
