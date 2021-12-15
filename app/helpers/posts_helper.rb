module PostsHelper
  def truncate_text(text)
    "#{text[0..25]}..."
  end
end
