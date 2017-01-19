class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :external_id
      t.string :email

      t.timestamps
    end

    add_index :users, :external_id
  end
end
