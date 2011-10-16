class BlogController < ApplicationController
  def index
    @entries = Blog.instance.entries
  end
end
