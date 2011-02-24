require 'spec_helper'

=begin
describe ProjectsController do
end
=end

describe ProjectsController do
  let(:user) { create_user! }

  let(:project) {Factory(:project) }

  context "standard users" do
  { "new" => "get",
    "create" => "post",
    "edit" => "get",
    "update" => "put",
    "destroy" => "delete" }.each do |action, method|
      it "cannot access the #{action} action" do
        sign_in(:user, user)
        send(method, action.dup, :id => project.id)
        response.should redirect_to(root_path)
        flash[:alert].should eql("You must be an admin to do that.")
      end
    end
  end


  it "displays an error message when asked for a missing project" do
    sign_in(:user, user)
    get :show, :id => "not-here"
    response.should redirect_to(projects_path)
    flash[:alert].should eql("The project you were looking for could not be found.")
  end

  it "cannot access the show action" do
    sign_in(:user, user)
    get :show, :id => project.id
    response.should redirect_to(projects_path)
    flash[:alert].should eql("The project you were looking for could not be found.")
  end
end

