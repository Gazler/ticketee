admin_user = Factory(:user, :email => "admin@ticketee.com")
admin_user.admin = true
admin_user.confirm!
Factory(:project, :name => "Ticketee Beta")

