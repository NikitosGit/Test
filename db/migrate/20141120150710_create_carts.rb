class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
    	t.integer :user_id #обязательное имя для связи с User
	t.timestamps
    end
  end
end
