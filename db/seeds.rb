# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Added by Refinery CMS Pages extension
Refinery::Pages::Engine.load_seed

# Added by Refinery CMS Categories extension
Refinery::Categories::Engine.load_seed

# Added by Refinery CMS Ships extension
Refinery::Ships::Engine.load_seed

# Added by Refinery CMS Inquiries engine
Refinery::Inquiries::Engine.load_seed

# Added by Refinery CMS News engine
Refinery::News::Engine.load_seed

# Added by Refinery CMS Adds extension
Refinery::Adds::Engine.load_seed

# Added by Refinery CMS Siteclients extension
Refinery::Siteclients::Engine.load_seed

# Added by Refinery CMS Projects extension
Refinery::Projects::Engine.load_seed
