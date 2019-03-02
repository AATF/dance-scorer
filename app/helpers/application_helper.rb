module ApplicationHelper
  def page_title(extra_title = nil)
    default_text = "#{Setting.app_name} Dance Scorer"
    if extra_title
      title ="#{default_text} - #{extra_title}"
    else
      title = default_text
    end
    title
  end
end
