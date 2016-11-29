g# Tô Contribuindo controller
class ImContributingController < ApplicationController
  # Keep user name and email in a project that user post and search for users marked project
  def index
    ImContributing = ImContributing.all
    ImContributing.each do |m|
      user = User.find_user_by_id(m.user_id);

      m.author_name = (user!=nil) ? user.full_name : "anonymous"
      m.author_email = (user!=nil) ? user.email : "anonymous"
      m.author_profile = (user!=nil) ? user.profile : "anonymous"

    end
    render json: toContribuindo, methods:[:author_name, :author_email, :author_profile]
  end
end

