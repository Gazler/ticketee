require "spec_helper"

describe "/api/v1/project", :type => :api do
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
        get "#{url}.json", :token => token
        last_response.status.should eql(200)
        last_response.body.should eql(Project.readable_by(user).to_json)
        projects = JSON.parse(last_response.body)
        projects.any? { |p| p["project"]["name"] == "Inspector" }.should be_true
      end

      it "XML" do
        get "#{url}.xml", :token => token
        last_response.body.should eql(Project.readable_by(user).to_xml)
        projects = Nokogiri::XML(last_response.body)
        projects.css("project name").text.should eql("Inspector")
      end
    end
  end

  context "creating a project" do
    let(:url) { "/api/v1/projects" }

    it "sucessful JSON" do
      post "#{url}.json", :token => token,
                          :project => {
                            :name => "Ticketee"
                          }
      last_response.status.should eql(201)
      last_response.body.should eql(Project.find_by_name("Ticketee").to_json)
    end

   it "unsuccessful JSON" do
      post "#{url}.json", :token => token,
                          :project => {}
      last_response.status.should eql(422)
      errors = {"name" => "can't be blank"}
      last_response.body.should eql(errors.to_json)
    end
  end
end

