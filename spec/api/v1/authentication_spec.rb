require "spec_helper"
describe "API errors", :type => :api do
  let(:token) { "" }
  it "making a request with no token" do
    get "/api/v1/projects.json", "token="+token
    error = { :error => "Token is invalid." }
    last_response.body.should eql(error.to_json)
  end
end

