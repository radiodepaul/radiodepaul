preload_app true   # Load the app in the master
worker_processes 3 # amount of unicorn workers to spin up
timeout 30         # restarts workers that hang for 30 seconds

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection if defined? ActiveRecord::Base
end
