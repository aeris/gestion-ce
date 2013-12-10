year = Year.create! year: Date.today.year

social = Account.create! number: 41020009148, tag: :social, name: 'Œuvres sociales'
operating = Account.create! number: 41020009147, tag: :operating, name: 'Fonctionnement'

rungis = Agency.create! name: 'Rungis'
lyon = Agency.create! name: 'Lyon'
toulouse = Agency.create! name: 'Toulouse'

rungis.staffs.create! year: year, number: 115
lyon.staffs.create! year: year, number: 92
toulouse.staffs.create! year: year, number: 64

User.create! name: 'Vinot', surname: 'Nicolas', login: 'nvinot', agency: rungis, password: User.hash_password('password')

social = social.budgets.create! year: year, residual: 12_129, account: social
operating = operating.budgets.create! year: year, residual: 10_000, account: operating

social.payments.create! date: Date.today, amount: 20_000
social.payments.create! date: Date.today, amount: 10_000
operating.payments.create! date: Date.today, amount: 10_000

5.times do
	activity = rungis.activities.create! year: year, date: Date.today, description: 'test', plan_debit: 1_000, plan_credit: 500, closed: true

	5.times do
		activity.entries.create! date: Date.today, description: 'test',
														 amount: rand(0..1_000),
														 category: :check, number: rand(0..10_000), bank: 'CC',
														 state: :new, budget: social
		activity.entries.create! date: Date.today, description: 'test',
														 amount: rand(0..1_000),
														 category: :check, number: rand(0..10_000), bank: 'CC',
														 state: :new, budget: operating
	end
end
