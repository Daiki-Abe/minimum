module ApplicationHelper
  def user_menu_list(instance)
    user_signed_in? && current_user.id == instance.user_id
  end
end
