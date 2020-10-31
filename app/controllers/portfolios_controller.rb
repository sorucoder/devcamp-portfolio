class PortfoliosController < ApplicationController
  before_action :set_portfolio_item, only: [:edit, :update, :show, :destroy]
  layout 'portfolio'
  access all: [:show, :index, :angular_items, :rails_items], user: {except: [:new, :create, :update, :edit, :destroy, :sort]}, site_admin: :all

  def index
    @portfolio_items = Portfolio.by_position
    @page_title = "My Portfolio | Marcus Germano, IV Portfolio"
  end

  def sort
    params[:order].each do |key, value|
      Portfolio.find(value[:id]).update(position: value[:position])
    end

    render nothing: true
  end

  def angular_items
    @portfolio_items = Portfolio.angular_items
  end

  def rails_items
    @portfolio_items = Portfolio.rails_items
  end

  def new
    @portfolio_item = Portfolio.new
    @page_title = "New Portfolio Item | Marcus Germano, IV Portfolio"
  end

  def create
    @portfolio_item = Portfolio.new(portfolio_params)

    respond_to do |format|
      if @portfolio_item.save
        format.html { redirect_to portfolios_path, notice: 'Your portfolio item is now live.'}
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @page_title = "Edit #{@portfolio_item.title} | Marcus Germano, IV Portfolio"
  end

  def update
    respond_to do |format|
      if @portfolio_item.update(portfolio_params)
        format.html { redirect_to portfolios_path, notice: 'The portfolio item was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def show
  end

  def destroy
    # Destroy/delete the record
    @portfolio_item.destroy

    # Redirect
    respond_to do |format|
      format.html { redirect_to portfolios_url, notice: 'Portfolio item was removed.' }
    end
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(
        :title,
        :subtitle,
        :body,
        :main_image,
        :thumb_image,
        technologies_attributes: [
          :id,
          :name,
          :_destroy
        ]
    )
  end

  def set_portfolio_item
    @portfolio_item = Portfolio.find(params[:id])
  end
end
