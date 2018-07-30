defmodule Web.DIContainerPlug do
  @behaviour Plug

  def init(options) do
    options
  end

  def call(conn, _options) do
    conn
  end
end
