require 'bundler'
Bundler.require()

configure { set :server :puma }

get '/' do
	render :html, :index
end

get '/say_hello' do

	@message = "This file is not used, since we are using MVC."

 	erb :hello

end
