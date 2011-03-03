require "spec_helper"

describe "/api/v1/Project", :type => :api do
  let(:user) do
    user = create_user!
    user.update_attribute(:admin, true)
    user
  end

  let(:token) { user.authentication_token }
  let(:project) { Factory(:project, :name => "Inspector") }

  context "projects viewable by this user" do


    before do
      user.permissions.create!(:action => "view", :object => project)
      #Factory(:project)
    end

    context "index" do
      let(:url) { "/api/v1/projects" }
      it "JSON" do
        get "#{url}.json" "token="+token
        last_response.body.should eql(Project.readable_by(user).to_json)
        last_response.status.should eql(200)
        projects = JSON.parse(last_response.body)
        projects.any? { |p| p["project"]["name"] == "Inspector" }.should be_true
      end
    end
  end
end

