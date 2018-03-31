module PushType
  class Asset < ActiveRecord::Base

    include PushType::Trashable

    dragonfly_accessor :file

    belongs_to :uploader, class_name: 'PushType::User', optional: true

    validates :file, presence: true

    default_scope { order(created_at: :desc) }

    scope :image,     -> { where(['mime_type LIKE ?', 'image/%']) }
    scope :not_image, -> { where(['mime_type NOT LIKE ?', 'image/%']) }

    before_create :set_mime_type
    after_destroy :destroy_file!

    def kind
      return nil unless file_stored?
      case mime_type
        when /\/vnd\.adobe/               then :file

        when /\Aaudio\/.*\z/              then :audio
        when /\Aimage\/.*\z/              then :image
        when /\Avideo\/.*\z/              then :video

        when /\/vnd.*wordprocessingml/,
             /\/vnd\.msword\z/,
             /\Atext\/(plain|rtf)\z/      then :doc
        when /\/pdf\z/                    then :pdf
        when /\/vnd.*spreadsheetml/,
             /\/vnd\.ms-excel\z/          then :sheet
        when /\/vnd.*presentationml/,
             /\/vnd\.ms-powerpoint\z/     then :slides

        when /\/(css|html|javascript|json)\z/,
             /\/.*xml.*\z/                then :code
        when /\/csv\z/                    then :csv
        when /\/(g?zip|x.+compressed)\z/  then :zip
        else :file
      end
    end

    [:audio, :image, :video].each do |k|
      define_method("#{k}?".to_sym) { kind == k }
    end

    def svg?
      mime_type =~ /\Aimage\/svg/
    end

    def description_or_file_name
      description? ? description : file_name
    end

    def media(style = nil)
      return file if !image? || svg? || style.blank?

      case style.to_sym
        when :original        then file
        when :push_type_thumb then preview_thumb
        else
          size = PushType.config.media_styles[style.to_sym] || style
          file.thumb(size)
      end
    end

    def preview_thumb(size = '300x300')
      return unless image?

      width, height = size.split('x').map(&:to_i)

      if file.width >= width && file.height >= height
        file.thumb("#{ size }#")
      else
        file.convert("-background white -gravity center -extent #{ size }")
      end
    end

    private

    def set_mime_type
      self.file_ext   = file.ext
      self.mime_type  = file.mime_type
    end

    def destroy_file!
      self.file.destroy!
    end

  end
end
