defmodule Web.DIContainerPlug do
  @behaviour Plug

  def init(options) when is_map(options) do
    options
  end

  def call(conn, options) do
    Plug.Conn.assign(conn, :di_container, options)
  end
end
