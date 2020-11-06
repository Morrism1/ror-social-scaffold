module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def left_menu_link
    class_name = 'menu-item'
    if current_user
      (content_tag(:div, class: class_name) do
        menu_link_to('Friend Requests', user_friendships_path(current_user.id))
      end) +
        link_to('Sign out', destroy_user_session_path, method: :delete)
    else
      link_to('Sign in', user_session_path)
    end
  end

  def bootstrap_class_for flash_type
    { success: "success", error: "danger", alert: "alert", notice: "notice" }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "#{bootstrap_class_for(msg_type)}", role: "alert") do 
              concat message 
            end)
    end
    nil
  end
end
