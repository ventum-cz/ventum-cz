require "smartcropper"

module Jekyll

  class PostThumbnailImage < StaticFile
    def initialize(site, base, dir, name)
      @site = site
      @base = base
      @dir = dir
      @dest_dir = File.join("images", "thumbnail")
      @name = name
    end

    def destination(dest)
      File.join(dest, @dest_dir, @name)
    end

    def write(dest)
      dest_path = destination(dest)

      return false if File.exist?(dest_path) and !modified?
      @@mtimes[path] = mtime

      FileUtils.mkdir_p(File.dirname(dest_path))
      SmartCropper.from_file(path).smart_crop_and_scale(96, 96).write(dest_path)

      true
    end
  end

  class PostThumbnailGenerator < Generator
    def generate(site)
      site.posts.each {|post|
        if post.data.has_key?("nahled")
          site.static_files << PostThumbnailImage.new(site, site.source, "images", File.basename(post.data["nahled"])) # Only works if post image is in src/images/ folder.
        end
      }
    end
  end

end

