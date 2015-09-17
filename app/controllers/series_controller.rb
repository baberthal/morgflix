class SeriesController < ApplicationController
  before_action :set_series, only: [:show, :edit, :update, :destroy]

  # GET /series
  # GET /series.json
  def index
    @series = Series.all
  end

  # GET /series/1
  # GET /series/1.json
  def show
  end

  # GET /series/new
  def new
    @series = Series.new
  end

  # GET /series/1/edit
  def edit
  end

  # POST /series
  # POST /series.json
  def create
    @series = Series.new(series_params)

    respond_to do |format|
      if @series.save
        format.html { _html_success @series, 'successfully created.' }
        format.json { _json_success :show, :created, @series }
      else
        format.html { render :new }
        format.json { _json_error :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /series/1
  # PATCH/PUT /series/1.json
  def update
    respond_to do |format|
      if @series.update(series_params)
        format.html { _html_success @series, 'successfully updated.' }
        format.json { _json_success :show, :ok, @series }
      else
        format.html { render :edit }
        format.json { _json_error :unprocessable_entity }
      end
    end
  end

  # DELETE /series/1
  # DELETE /series/1.json
  def destroy
    @series.destroy
    respond_to do |format|
      format.html { _html_success series_index_url, 'successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_series
    @series = Series.find(params[:id])
  end

  def series_params
    params.require(:series).permit(:name,
                                   :language,
                                   :external_id,
                                   :default_banner)
  end

  def _html_success(redirect, message)
    redirect_to redirect, notice: "Series was #{message}"
  end

  def _json_success(action, status, location)
    render action, status: status, location: location
  end

  def _json_error(status)
    render json: @series.errors, status: status
  end
end
