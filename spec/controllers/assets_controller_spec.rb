require 'spec_helper'

describe AssetsController do
  let(:project) { Project.create(:name => "Ticketee") }

  let(:good_user) do
    create_user!
  end

  let(:bad_user) do
    create_user!(:email => "other_user@ticketee.com")
  end

  let(:ticket) do
    project.tickets.create(:title => "File attachment",
    :description => "A wild file appears!")
  end

  let(:path) { Rails.root + "spec/fixtures/speed.txt" }

  let(:asset) do
    ticket.assets.create(:asset => File.open(path))
  end

  before do
    good_user.permissions.create!(:action => "view", :object => project)
  end

  context "users with access" do
    before do
      sign_in(:user, good_user)
    end

    it "can access assets in a project" do
      get 'show', :id => asset.id
      response.body.should eql(File.read(path))
    end
  end

  context "users without access" do
    before do
      sign_in(:user, bad_user)
    end

    it "cannot access assets in this project" do
      get 'show', :id => asset.id
      response.should redirect_to(root_path)
      flash[:alert].should eql("The asset you were looking for could not be found.")
    end
  end
end

