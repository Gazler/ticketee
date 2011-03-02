require 'spec_helper'

describe TicketsController do
  let(:user) { create_user! }
  let(:project) { Factory(:project) }
  let(:ticket) { Factory(:ticket, :project => project) }


  context "with permission to view the project" do
    before do
      sign_in(:user, user)
      Permission.create(:user_id => user, :object => project, :action => "view")
    end

    def cannot_create_tickets!
      response.should redirect_to(project)
      flash[:alert].should eql("You are not allowed to create tickets on this project.")
    end

    def cannot_update_tickets!
      response.should redirect_to(project)
      flash[:alert].should eql("You are not allowed to edit tickets on this project.")
    end

    it "cannot begin to create a ticket" do
      get :new, :project_id => project.id
      cannot_create_tickets!
    end

    it "cannot create a ticket without permission" do
      post :create, :project_id => project.id
      cannot_create_tickets!
    end

    it "cannot edit a ticket without permission" do
      get :edit, { :project_id => project.id, :id => ticket.id }
      cannot_update_tickets!
    end

    it "cannot update a ticket without permission" do
      put :update, { :project_id => project.id, :id => ticket.id }
      cannot_update_tickets!
    end

    it "cannot delete a ticket without permission" do
      delete :destroy, { :project_id => project.id, :id => ticket.id }
      response.should redirect_to(project)
      flash[:alert].should eql("You are not allowed to delete tickets in this project.")
    end

    it "can create tickets, but not tag them" do
      Permission.create(:user => user, :object => project, :action => "create tickets")
      post :create, :ticket => { :title => "New ticket!",
      :description => "Brand spankin' new" },
      :project_id => project.id,
      :tags => "these are tags"
      Ticket.last.tags.should be_empty
    end



  end



  context "standard users" do
    it "cannot acces a ticket for a project they don't have access to" do
      sign_in(:user, user)
      get :show, :id => ticket.id, :project_id => project.id
      response.should redirect_to(root_path)
      flash[:alert].should eql("The project you were looking for could not be found.")
    end
  end

end

