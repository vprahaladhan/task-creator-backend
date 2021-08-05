class CreateAuthenticateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :authenticate_users do |t|

      t.timestamps
    end
  end
end
