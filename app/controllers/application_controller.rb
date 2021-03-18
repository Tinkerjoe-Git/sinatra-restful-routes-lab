class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/recipes' do
    erb :index
  end


  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    
    if recipe=Recipe.create(:name=> params[:name] , :ingredients=> params[:ingredients], :cook_time=> params[:cook_time])
      redirect "/recipes/#{recipe.id}"
    else
      redirect '/recipes/new'
    end
  end

  get '/recipes/:id' do
    @recipe=Recipe.find(params[:id])
    erb :show
  end


  patch '/recipes/:id' do 
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do 
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end 

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  

end
