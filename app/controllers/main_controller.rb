class MainController < ApplicationController
  def index
  end

  def about
  end

  def contacts
  end

  # route is temporary disabled
  def friendship
    @children = Child.want_to_be_friends.order(id: :asc)
  end
end
