# frozen_string_literal: true

class Article < ApplicationRecord
  validates :content, presence: true
end
