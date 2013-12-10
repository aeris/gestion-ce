class User < ActiveRecord::Base
	belongs_to :agency
	validates_presence_of :login, :name, :password, :surname, :agency
	validates_uniqueness_of :login

	before_validation do
		self.login ||= (self.surname[0] + self.name).downcase
	end

	before_create do
		self.password = User.hash_password self.password
	end

	def self.hash_password(password)
		Digest::SHA512.hexdigest password
	end

	def display_name
		"#{self.surname} #{self.name}"
	end
end
