defmodule Rocketpay.Friendship.Friend do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rocketpay.User

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:user_id, :addresse_id, :accepted]

  schema "friends" do
    field :addresse_id, :binary_id
    belongs_to :user, User, foreign_key: :user_id, type: :binary_id
    field :accepted, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end
end
