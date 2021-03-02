defmodule Rocketpay.Repo.Migrations.CreateTransactionTable do
  use Ecto.Migration

  def change do
    create table :transactions do
      add :value, :decimal
      add :is_private, :boolean, default: :false, null: false
      add :account_id_from, references(:users, type: :binary_id)
      add :account_id_to, references(:users, type: :binary_id)
    end

    create constraint(:transactions, :value_must_be_positive, check: "value > 0")
  end
end
