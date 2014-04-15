require 'sinatra'
require 'net/http'
require 'json'
require 'open-uri'

get '/' do
  if params[:query]
    encoded_query = URI::encode(params[:query])

    uri = URI("https://jobs.github.com/positions.json?description=#{encoded_query}&location=boston")
    response = Net::HTTP.get(uri)

    parsed_jobs = JSON.parse(response)

    @jobs = []
    parsed_jobs.each do |job|
      @jobs << { title: job["title"], url: job["url"] }
    end
  end

  erb :index
end
