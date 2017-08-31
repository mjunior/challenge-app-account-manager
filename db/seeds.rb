# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
NaturalPerson.create(full_name: "Maurício Júnior", cpf: "12063963690", birthdate: Time.now )
Main.create(person: NaturalPerson.first, name: "100")
Main.first.branches << Branch.new(name: "100.1", person: Person.first )
Main.first.branches << Branch.new(name: "100.2", person: Person.first )
Main.first.branches << Branch.new(name: "100.3", person: Person.first )