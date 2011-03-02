admin_user = Factory(:user, :email => "admin@ticketee.com")
admin_user.admin = true
admin_user.confirm!
Factory(:project, :name => "Ticketee Beta")

State.create( :name => "New",
              :background => "#85FF00",
              :color=> "white")

State.create( :name => "Open",
              :background => "#00CFFD",
              :color => "white")

State.create( :name => "Closed",
              :background => "black",
              :color=> "white")

