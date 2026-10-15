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

  def app_version
    rails_root = defined?(Rails.root) && Rails.root ? Rails.root : Pathname.new(Dir.pwd)
    version_file = [
      rails_root.join("VERSION"),
      rails_root.join("../VERSION")
    ].find { |path| File.file?(path) }

    return unless version_file

    version = File.read(version_file).strip
    version.presence
  rescue StandardError
    nil
  end
end
