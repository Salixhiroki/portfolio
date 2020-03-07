class Comment < ApplicationRecord

validates :content, length: {in: 1..200}

belongs_to :user
belongs_to :recipe

end
