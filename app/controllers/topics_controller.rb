class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :destroy]
  before_action :set_sidebar_topics, except: [:destroy]
  layout 'blog'
  access all: [:show, :index], user: {except: [:new, :edit, :create, :destroy]}, site_admin: :all

  def index
    @topics = Topic.all
  end

  def show
    @blogs = Blog.by_topic(params[:id])
    if logged_in?(:site_admin)
      @blogs = @blogs.recent.page(params[:page]).per(5)
    else
      @blogs = @blogs.published.recent.page(params[:page]).per(5)
    end
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to blogs_path, notice: 'Topic was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to blogs_path, notice: 'Topic was successfully removed.' }
    end
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title)
  end
end
