u = User.create!(:email=>'sufia@uvic.ca',:display_name=>'Sufia Admin',:password=>'password')
u.save
r = Role.create name: "admin"
r.users << u
r.save