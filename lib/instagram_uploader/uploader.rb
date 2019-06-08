require "instagram_uploader/login"
require "instagram_uploader/photo_uploader"
require "instagram_uploader/photo_commit"
require "instagram_uploader/video_uploader"

require "curb"
require "tempfile"

module InstagramUploader
  class Uploader
    include Login
    include PhotoUploader
    include PhotoCommit
    include VideoUploader


    def initialize(username, password)
      @username = username
      @password = password
      @cookie = Tempfile.new('cookies').path
    end

    def upload(image_path, desc)
      login
      media_response = upload_photo(image_path)
      commit_photo(media_response['media_id'], desc)
    end

    def uploadVideo(video_path, desc)
      login
      media_response = upload_video(video_path)
      # commit_photo(media_response['media_id'], desc)
    end

    private


    class Error < RuntimeError
    end
  end

end
