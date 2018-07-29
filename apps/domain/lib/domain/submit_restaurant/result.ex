defmodule Result do
  defstruct [:type, :data]

  def succeed(data) do
    %__MODULE__{type: :success, data: data}
  end

  def fail(reason) do
    %__MODULE__{type: :failure, data: reason}
  end

  def map(%__MODULE__{type: :success, data: data} = result, f) do
    %__MODULE__{result | data: f.(data)}
  end

  def map(%__MODULE__{type: :failure} = result, _) do
    result
  end

  def bind(%__MODULE__{type: :success, data: data}, f) do
    f.(data)
  end

  def bind(%__MODULE__{type: :failure} = result, _) do
    result
  end
end
