class GroupsController < ApplicationController
  before_action :require_login

  def index
    @groups = Group.all
  end
end
