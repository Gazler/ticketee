Given /^"([^"]*)" can ([^"]*?) ([o|i]n)?\s?the "([^"]*)" project$/ do |user, permission, on, project|
  create_permission(user, find_project(project), permission)
end

def create_permission(email, object, action)
  Permission.create!(:user_id => User.find_by_email!(email), :object => object, :action => action)
end

def find_project(name)
  Project.find_by_name!(name)
end

