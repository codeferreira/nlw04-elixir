defmodule Rocketpay.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset
  alias Rocketpay.{Account, Encryption, Friendship}

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [
    :name,
    :age,
    :email,
    :password,
    :password_confirmation,
    :nickname,
    :is_private
  ]

  schema "users" do
    field :name, :string
    field :age, :integer
    field :email, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    field :nickname, :string
    field :is_private, :boolean, default: false
    has_one :account, Account
    has_many :friends, Friendship.Friend

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:nickname])
    |> downcase_username()
    |> encrypt_password()
  end

  defp encrypt_password(changeset) do
    case changeset do
      %Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Encryption.hash_password(password))

      _ ->
        changeset
    end
  end

  defp downcase_username(changeset) do
    update_change(changeset, :nickname, &String.downcase/1)
  end
end
