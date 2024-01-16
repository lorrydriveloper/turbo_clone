# frozen_string_literal: true

require 'test_helper'

class TurboClone::StreamsControllerTest < ActionDispatch::IntegrationTest
  teardown do
    article = Article.find_by(content: 'Hello, World!')
    article&.destroy
  end
  test 'create with respond to format HTML' do
    post articles_path, params: { article: { content: 'Hello, World!' } }
    assert_redirected_to articles_path
  end
  test 'update with respond to format HTML' do
    article = Article.create!(content: 'Hello, Test!')
    patch article_path(article), params: { article: { content: 'Hello, World!' } }
    assert_redirected_to articles_path
  end
  test 'destroy with respond to format HTML' do
    article = Article.create!(content: 'Hello, Test!')
    delete article_path(article)
    assert_redirected_to articles_path
  end

  test 'create with respond to format TURBO_STREAM' do
    post articles_path, params: { article: { content: 'Hello, World!' } }, headers: headers

    assert_turbo_stream(action: 'prepend', target: 'articles')
    assert_turbo_stream(action: 'update', target: 'new_article')
  end

  test 'update with respond to format TURBO_STREAM' do
    article = Article.create!(content: 'Hello, Test!')
    patch article_path(article), params: { article: { content: 'Hello, World!' } }, headers: headers
    assert_turbo_stream(action: 'replace', target: article)
  end
  test 'destroy with respond to format TURBO_STREAM' do
    article = Article.create!(content: 'Hello, Test!')
    delete article_path(article), headers: headers
    assert_turbo_stream(action: 'remove', target: article)
  end

  private

  def headers
    @headers ||= { 'Accept' => 'text/vnd.turbo-stream.html' }
  end
end
