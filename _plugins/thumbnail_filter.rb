module Jekyll
  module PostThumbnail
    def post_thumbnail(input)
      input.sub("images/", "images/thumbnail/")
    end
  end
end

Liquid::Template.register_filter(Jekyll::PostThumbnail)

