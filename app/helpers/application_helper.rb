module ApplicationHelper
  def host?(user)
    return false unless current_user
    current_user.id == user.id
  end
end
