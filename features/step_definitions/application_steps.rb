Then /^I should see the "([^"]*)" link$/ do |text|
  css("a").detect { |a| a.text == text }.should_not(be_nil,
    "Expected to see the #{text.inspect} link, but did not.")
end

Then /^I should not see the "([^\"]*)" link$/ do |text|
 css("a").detect { |a| a.text == text }.should(be_nil,
  "Expected to not see the #{text.inspect} link, but did.")
end

Given /^I have run the seed task$/ do
  load Rails.root + "db/seeds.rb"
end

Then /^I should not see the "([^"]*)" element$/ do |text|
  lambda { find(:css, css) }.should(
    raise_error(Capybara::ElementNotFound, "Unable to find '#{css}'")
  )
end


def css(selector)
  Nokogiri::HTML(body).css(selector)
end

