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
    # @entries = Blog.instance.archive(params[:year], params[:month], params[:day])
    # @title = "archive - blog.mah-lab.com"
    # render :nothing => true, :status => 404 unless @entries
    #
    # Achiveページは廃止して、Backnumberページのみ提供する。
    # 記事が増えてきたら検索ボックス、Taggingなどを追加してUIを向上させる。
    redirect_to root_path
  end

  def entry
    @entry = Blog.instance.entry(params[:year], params[:month], params[:day], params[:slug])
    @prev = @entry.prev
    @next = @entry.next
    @title = @entry.title + " - blog.mah-lab.com"
    render :nothing => true, :status => 404 unless @entry
  end

  def backnumber
    @entries = Blog.instance.backnumber
    @title = "back number - blog.mah-lab.com"
    render :nothing => true, :status => 404 unless @entries
  end
end
