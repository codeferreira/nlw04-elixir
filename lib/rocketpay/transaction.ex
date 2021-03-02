defmodule Rocketpay.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias Rocketpay.Account

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [
    :value,
    :account_id_from,
    :account_id_to
  ]

  schema "transaction" do
    field :value, :decimal
    field :is_private, :boolean, default: false
    belongs_to :account_from, Account, foreign_key: :account_id_from
    belongs_to :account_to, Account, foreign_key: :account_id_to

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> check_constraint(:value, name: :value_must_be_positive)
  end
end
