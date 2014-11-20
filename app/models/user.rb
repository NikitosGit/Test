class User < ActiveRecord::Base
	#attr_accessible :login
	has_one :cart
end
