# frozen_string_literal: true

class Cookmethod < ApplicationRecord
  belongs_to :recipe, optional: true
end
