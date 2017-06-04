# frozen_string_literal: true

# Search Page Helper
module SearchHelper
  def sortable_header(column, display, keywords, order, direction)
    query = '?' + {
      q: keywords,
      order: column,
      direction: direction == :desc ? 'asc' : 'desc'
    }.to_query

    sort_direction = if column == order.to_s
                       direction
                     else
                       'desc'
                     end

    content_tag 'a', href: query do
      concat display + ' '
      concat content_tag('i', '', class: "fa fa-sort-#{sort_direction}")
    end
  end
end
