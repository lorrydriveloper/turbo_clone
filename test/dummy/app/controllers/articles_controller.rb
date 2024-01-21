# frozen_string_literal: true

# Public: The Controller for Article model CRUD.
# that follow the company pattern of move logic to managements.
# It follow REST pattern, PERMITTED_PARAMS are defined at Model level.

class ArticlesController < ApplicationController
  before_action :set_article, except: %i[index new create]

  def index
    @articles = Article.all
  end

  def show; end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = Article.new(article_params)
    if @article.save
      respond_to do |format|
        format.html { redirect_to articles_path }
        format.turbo_stream
      end
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      respond_to do |format|
        format.html { redirect_to articles_path }
        format.turbo_stream
      end
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_path }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@article) }
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:content)
  end
end
