class Gallery < ApplicationRecord
  has_and_belongs_to_many :uploads

  belongs_to :user
end
