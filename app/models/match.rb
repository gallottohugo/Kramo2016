class Match < ActiveRecord::Base
	has_many :user_matches
	has_many :numbers
end
