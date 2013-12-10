#encoding: utf-8

ActiveRecord::Base.transaction do
	year = Year.create! year: Date.today.year

	agency = Agency.create! name: 'Agency'

	User.create! name: 'Admin', surname: 'Admin', login: 'admin', agency: agency,
			password: 'password'

	social = Account.create! number: 1, tag: :social, name: 'Œuvres sociales'
	operating = Account.create! number: 2, tag: :operating, name: 'Fonctionnement'
	social = social.budgets.create! year: year, residual: 0, account: social
	operating = operating.budgets.create! year: year, residual: 0, account: operating
end
