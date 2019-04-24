require_relative '../../config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # NEW
  get '/articles/new' do
    erb :new
  end

  # CREATE
  post '/articles' do
    @article = Article.create(params)
    redirect "/articles/#{@article.id}"
  end

  # SHOW
  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  # INDEX
  get '/articles' do
    @articles = Article.all
    erb :index
  end

  # EDIT
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  # UPDATE
  patch '/articles/:id' do
    params.reject! { |k, _| k == '_method' }

    # Article.update(params)
    article = Article.find(params[:id])
    article.title = params[:title]
    article.content = params[:content]
    article.save

    redirect "/articles/#{@article.id}"
  end

  # DELETE
  delete '/articles/:id' do
    Article.find(params[:id]).destroy
    redirect '/articles'
  end

  # ROOT
  get '/' do
    redirect '/articles'
  end
end
