defmodule Rocketpay.Friendship.Friend do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rocketpay.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:user_id, :addresse_id, :accepted]
  @foreign_key_type :binary_id

  schema "friends" do
    field :accepted, :boolean, default: false
    belongs_to :user, User, foreign_key: :user_id
    belongs_to :addresse, User, foreign_key: :addresse_id

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> unique_constraint([:user_id, :addresse_id], name: :unique_friendship)
  end
end
