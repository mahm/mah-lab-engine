# coding: utf-8
class BlogController < ApplicationController

  def index
    page = params["page"].to_i
    page = 1 if page < 1
    @entries = Blog.instance.entries(page)
    @title = "blog.mah-lab.com"
    respond_to do |format|
      format.html
      format.xml
    end
  end

  def archive
    @entries = Blog.instance.archive(params[:year], params[:month], params[:day])
    @title = "blog.mah-lab.com"
    render :nothing => true, :status => 404 unless @entries
  end

  def entry
    @entry = Blog.instance.entry(params[:year], params[:month], params[:day], params[:slug])
    @title = @entry.title
    render :nothing => true, :status => 404 unless @entry
  end
end
