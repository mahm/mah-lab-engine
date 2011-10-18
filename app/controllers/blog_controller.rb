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
    @title = "blog.mah-lab.com - archive"
    render :nothing => true, :status => 404 unless @entries
  end

  def entry
    @entry = Blog.instance.entry(params[:year], params[:month], params[:day], params[:slug])
    @title = @entry.title
    render :nothing => true, :status => 404 unless @entry
  end

  def backnumber
    @entries = Blog.instance.backnumber
    @title = "blog.mah-lab.com - back number"
    render :nothing => true, :status => 404 unless @entries
  end
end
