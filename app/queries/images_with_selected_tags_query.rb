class ImagesWithSelectedTagsQuery < Patterns::Query
  queries Image

  private

  def query
    if tags_array.present?
      relation.joins(:tags).group(:id).having("EVERY(tags.name IN (?))", tags_array)
    else
      relation
    end
  end

  def tags_array
    tags_option = options.fetch(:tags) || []
    tags_option.select(&:present?)
  end
end