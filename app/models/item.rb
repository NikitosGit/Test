class Item < ActiveRecord::Base
	#attr_accessible :price, :name, :real, :weight, :description - не работает
	validates :price, numericality: {greater_than: 0, allow_nil: true}
	validates :name, :description, presence: true

	#CallBacks
	#after_initialize {puts "initialized"} #Item.new, Item.first
	after_save		 {puts "saved"} #Item.save, Item.create, Item.update_attributes
	after_create	 {puts "created"}
	# Пример after_create	 {ItemMailer.new_item_created(self).deliver}
	after_update	 {puts "updated"}
	after_destroy	 {puts "destroyed"} #111
end
