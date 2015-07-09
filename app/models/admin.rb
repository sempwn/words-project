class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
   validate :single_admin

	def single_admin
		if Admin.all.count > 0
			errors.add(:base, "Can only have one admin.")
		end
	end

end
