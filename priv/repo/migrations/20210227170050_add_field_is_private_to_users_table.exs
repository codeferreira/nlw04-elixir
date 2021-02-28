defmodule Rocketpay.Repo.Migrations.AddFieldIsPrivateToUsersTable do
  use Ecto.Migration

  def change do
    alter table "users" do
      add :is_private, :boolean, default: :false, null: false
    end
  end
end
