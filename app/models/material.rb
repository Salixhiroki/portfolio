# frozen_string_literal: true

class Material < ApplicationRecord
  belongs_to :recipe, optional: true
end
