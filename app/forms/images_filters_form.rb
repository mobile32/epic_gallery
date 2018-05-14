class ImagesFiltersForm < Patterns::Form
  param_key "images_filters"

  attribute :tags

  validates :tags, presence: true
end