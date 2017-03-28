class ForecastsController < ApplicationController

  def index

    city = "sanfrancisco"
    state = "ca"

    if params[:city] && params[:state]
      city = params[:city]
      state = params[:state]
    end

    @forecasts = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22"+city+"%2C%20"+state+"%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys").body['query']['results']['channel']['item'] #=> returning item hash

    @current_temp = @forecasts['condition']['temp']

    @five_day_forecast = @forecasts['forecast']

  end

end
