class SecretController < ApplicationController
  def index
    @series = Series.latest
    @selected = Series.latest.first
  end

  def search
    @results = Series.search_tvdb(params[:q])
  end
end
