# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin = User.find_or_initialize_by email: ENV['ADMIN_EMAIL']
admin.password = 'password'
admin.first_name = 'admin'
admin.last_name = 'admin'
admin.save!
admin.add_role :admin
