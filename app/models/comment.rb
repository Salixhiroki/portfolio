# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :content,{presence: true, length: { in: 1..200 }}

  belongs_to :user
  belongs_to :recipe
end
