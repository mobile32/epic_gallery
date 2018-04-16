module ApplicationHelper
  def full_name(user = nil)
    user.first_name.to_s + ' ' + user.last_name.to_s
  end
end
