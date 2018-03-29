# Load DSL and set up stages
require 'capistrano/setup'


# Include default deployment tasks
require 'capistrano/deploy'

# use Git as a default SCM
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Include tasks from other gems included in Gemfile
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/puma'
install_plugin Capistrano::Puma
require 'capistrano/sidekiq'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
