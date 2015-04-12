module ApplicationHelper
  def show_avatar(player)
    if player.avatar?
      player.avatar
    else
      image_tag "default.gif"
    end
  end

  def pretty_date(date)
    date.strftime("%d %b %Y")
  end
end
