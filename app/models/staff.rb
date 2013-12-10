class Staff < ActiveRecord::Base
	belongs_to :agency
	belongs_to :year
	validates_presence_of :number, :agency, :year
	validates_uniqueness_of :year_id, scope: :agency_id

	def self.current agency
		self.get Year.current, agency
	end

	def self.get year, agency
		Staff.where(year_id: year, agency_id: agency).first!
	end
end
