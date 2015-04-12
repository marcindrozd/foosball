module ApplicationHelper
  def show_avatar(player)
    if player.avatar?
      image_tag player.avatar.url
    else
      image_tag "default.gif"
    end
  end

  def pretty_date(date)
    date.strftime("%d %b %Y")
  end

  def sortable(column, title = nil)
    title ||= column.split("_").join(" ").titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == 'desc') ? 'asc' : 'desc'
    link_to title, { sort: column, direction: direction }, { class: css_class }
  end
end
