module ApplicationHelper
  def full_name(user = nil)
    user.first_name + ' ' + user.last_name
  end
end
