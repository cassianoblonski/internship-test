# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Map.create(name: "Halan Map", point_connections: { A:{B:10, C:20}, B:{D:15, E:50}, C:{D:30}, D:{E:30} })
