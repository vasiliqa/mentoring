class MainController < ApplicationController
  def index
  end

  def about
  end

  def contacts
  end

  def mentors
    @mentors = User.to_display
  end
end
