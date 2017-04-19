class PoochPads < Sinatra::Base

  get '/pads' do
    @pads = Pad.all
    erb :'pads/index'
  end

  get '/pads/new' do
    unless current_user
      flash.keep[:login] = 'Please sign up or log in to add a pad'
      redirect '/users/new'
    else
      erb :'pads/new'
    end
  end

  post '/pads' do
    pad = Pad.create(name: params[:name],
                     price: params[:price],
                     location: params[:location],
                     about: params[:about])
    current_user.pads << pad
    current_user.save
    redirect '/pads'
  end

  post '/pads/:id' do
    session[:pad_id] = params[:id]
    redirect '/pads/request'
  end

  get '/pads/request' do
    @selected_pad = Pad.first(id: session[:pad_id])
    erb :'pads/request'
  end


end
