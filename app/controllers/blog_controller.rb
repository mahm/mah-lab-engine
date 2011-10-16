class BlogController < ApplicationController
  def index
    page = params["page"].to_i || 1
    @entries = Blog.instance.entries(page)
  end
end
