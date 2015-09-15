class SecretController < ApplicationController
  def index
    @series = Series.latest
    @selected = Series.latest.first
  end

  def search
    @results = Series.search_tvdb(params[:q])
    respond_to do |fmt|
      fmt.js
      fmt.json { render json: @results }
      fmt.html
    end
  end
end
