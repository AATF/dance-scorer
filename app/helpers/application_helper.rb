module ApplicationHelper
  def page_title(title = nil)
    if title
      "AATF Scorer - #{title}"
    else
      "AATF Scorer"
    end
  end
end
