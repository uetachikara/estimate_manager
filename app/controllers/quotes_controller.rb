class QuotesController < ApplicationController
  before_action :set_quote, only: %i[ show edit update destroy ]

  def index
    @quotes = current_user.quotes.includes(:project).order(created_at: :desc)
  end

  def show
  end

  def new
    @quote = current_user.quotes.new
    @projects = current_user.projects
  end

  def edit
    @projects = current_user.projects
  end

  def create
    @quote = current_user.quotes.new(quote_params)
    if @quote.save
      redirect_to @quote, notice: "Quote was successfully created."
    else
      @projects = current_user.projects
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @quote.update(quote_params)
      redirect_to @quote, notice: "Quote was successfully updated.", status: :see_other
    else
      @projects = current_user.projects
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @quote.destroy!
    redirect_to quotes_path, notice: "Quote was successfully destroyed.", status: :see_other
  end

  private

  def set_quote
    @quote = current_user.quotes.find(params.expect(:id))
  end

  def quote_params
    params.require(:quote).permit(:status, :subtotal, :issued_on, :note, :project_id)
  end
end

