defmodule Phauxth.Confirm do
  @moduledoc """
  Module to provide user confirmation for new users.

  ## Options

  There is one option:

    * `:log_meta` - additional custom metadata for Phauxth.Log
      * this should be a keyword list
  """

  use Phauxth.Confirm.Base

  @impl true
  def report({:ok, user}, meta) do
    if user.confirmed_at do
      Log.warn(%Log{user: user.id, message: "user already confirmed", meta: meta})
      {:error, Config.user_messages().already_confirmed()}
    else
      super({:ok, user}, meta)
    end
  end

  def report(result, meta), do: super(result, meta)
end
