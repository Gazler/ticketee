Given /^there are the following users:$/ do |table|
  table.hashes.each do |attributes|
    unconfirmed = attributes.delete("unconfirmed")
    @user = User.create!(
     attributes.merge!(
       :password_confirmation => attributes[:password]
      )
    )
    @user.confirm! unless unconfirmed
  end
end


Given /^I am signed in as them$/ do
  steps(%Q{
    Given I am on the homepage
    When I follow "Sign in"
    And I fill in "Email" with "#{@user.email}"
    And I fill in "Password" with "#{@user.password}"
    And I press "Sign in"
    Then I should see "Signed in successfully."
  })
end

