#sufia_chef 

cd sufia
bundle install

rails generate sufia:install -f
rails generate roles
rake db:migrate

rake jetty:clean
rake sufia:jetty:config
rake jetty:start

cd ../redis/redis-3.0.3
make
resque-pool --daemon --environment development start

#Edit User.rb
#Create new user and admin role

