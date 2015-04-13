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

  def options_for_players
    Player.where('id != ?', current_player.id).order(first_name: :asc).map { |p| [p.full_name, p.id] }
  end

  def display_trophy(player)
    if player.find_player_position == 1
      image_tag "Trophy-gold-icon.png", class: "trophy-img"
    elsif player.find_player_position == 2
      image_tag "Trophy-silver-icon.png", class: "trophy-img"
    elsif player.find_player_position == 3
      image_tag "Trophy-bronze-icon.png", class: "trophy-img"
    end
  end
end
