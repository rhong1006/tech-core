require 'news-api'
class NewsController < ApplicationController
  before_action :news_api, only: [:index]

  def index
    news_keyword = params[:news]
    if news_keyword
      keyword = news_keyword[:search_article].downcase
      @filtered_article_arr = []
      @all_articles.map { |a| @filtered_article_arr << a if a.title.downcase.include? keyword }
    else
       @filtered_article_arr = @all_articles
    end
  end

  private
  def news_api
    newsapi = News.new("c4b4a385626c44c892860ce47a35dc7a")
    @all_articles = newsapi.get_everything(
      q: 'Chinese',
      sources: 'bbc-news,the-verge',
      domains: 'bbc.co.uk,techcrunch.com',
      from: '2017-12-01',
      to: '2017-12-12',
      language: 'en',
      sortBy: 'relevancy',
      page: 2
    )
  end

end
