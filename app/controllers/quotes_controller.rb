class QuotesController < ApplicationController
  before_action :set_quote, only: %i[ show edit update destroy ]

  # GET /quotes or /quotes.json
  def index
    @quotes = current_user.quotes.includes(:project).order(created_at: :desc)
  end

  # GET /quotes/1 or /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    @quote = current_user.quotes.new
    @projects = current_user.projects
  end

  # GET /quotes/1/edit
  def edit
    @projects = current_user.projects
  end

  # POST /quotes or /quotes.json
  def create
    @quote = current_user.quotes.new(quote_params)
    if @quote.save
      redirect_to @quote, notice: "Quote was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quotes/1 or /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to @quote, notice: "Quote was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1 or /quotes/1.json
  def destroy
    @quote.destroy!

    respond_to do |format|
      format.html { redirect_to quotes_path, notice: "Quote was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def quote_params
      @quote = current_user.quotes.find(params.expect(:id))
    end
end
