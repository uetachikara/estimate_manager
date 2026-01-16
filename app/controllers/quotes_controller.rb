class QuotesController < ApplicationController
  before_action :set_quote, only: %i[ show edit update destroy ]
  before_action :set_projects, only: %i[new create edit update]

  def index
    @quotes = current_user.quotes.includes(:project).order(created_at: :desc)
  end

  def show
  end

  def new
    @quote = Quote.new
    @quote.quote_items.build
  end

  def edit
    @projects = current_user.projects
  end

  def create
    @quote = current_user.quotes.new(quote_params)
    if @quote.save
      redirect_to @quote, notice: t("notices.quote.created")
    else
      @projects = current_user.projects
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @quote.update(quote_params)
      redirect_to @quote, notice: t("notices.quote.updated"), status: :see_other
    else
      @projects = current_user.projects
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @quote.destroy!
    redirect_to quotes_path, notice: t("notices.quote.destroyed"), status: :see_other
  end

  private

  def set_quote
    @quote = current_user.quotes.find(params.expect(:id))
  end

  def set_projects
    @projects = current_user.projects.order(created_at: :desc)
  end

  def quote_params
    params.require(:quote).permit(
      :status,
      :project_id,
      :note,
      :issued_on,
      quote_items_attributes: [
        :id,
        :description,
        :quantity,
        :unit_price,
        :_destroy
      ]
    )
  end

end

