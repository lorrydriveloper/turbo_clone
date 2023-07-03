# frozen_string_literal: true

require 'test_helper'

class TurboClone::FramesHelperTest < ActionView::TestCase
  test 'frame with a model' do
    article = Article.new(content: 'Not need it.', id: 1)

    assert_dom_equal %(<turbo-frame id="article_1"></turbo-frame>), turbo_frame_tag(article)
  end

  test 'frame with a string' do
    assert_dom_equal %(<turbo-frame id="articles"></turbo-frame>), turbo_frame_tag('articles')
  end

  test 'accpets a block' do
    article = Article.new(content: 'Not need it.', id: 1)

    assert_dom_equal %(<turbo-frame id="article_1"><p>my articles</p></turbo-frame>),
                     turbo_frame_tag(article) { tag.p('my articles') }
  end
end
