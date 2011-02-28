module ApplicationHelper
  def title(*parts)
    @title = (parts << "Ticketee").join(" - ") unless parts.empty?
    @title || "Ticketee"
  end

  def admins_only(&block)
    if current_user && current_user.admin?
      block.call
    end
    nil
  end

  def authorized?(permission, object,  &block)
    if can?(permission.to_sym, object) || (current_user && current_user.admin?)
      block.call
    end
  nil
  end


end

