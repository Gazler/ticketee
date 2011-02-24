Given /^"([^"]*)" can view the "([^"]*)" project$/ do |user, project|
  Permission.create(:user_id => User.find_by_email!(user), :object => Project.find_by_name!(project), :action => "read")
end

