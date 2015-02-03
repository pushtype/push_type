module PushType
  class Asset < ActiveRecord::Base

    include PushType::Trashable

    dragonfly_accessor :file

    belongs_to :uploader, class_name: 'PushType::User'

    validates :file, presence: true

    default_scope { order(created_at: :desc) }

    scope :image,     -> { where(['mime_type LIKE ?', 'image/%']) }
    scope :not_image, -> { where(['mime_type NOT LIKE ?', 'image/%']) }

    before_create :set_mime_type
    after_destroy :destroy_file!

    def kind
      return nil unless file_stored?
      case mime_type
        when /\Aaudio\/.*\z/ then :audio
        when /\Aimage\/.*\z/ then :image
        when /\Avideo\/.*\z/ then :video
        else :document
      end
    end

    [:audio, :image, :video].each do |k|
      define_method("#{k}?".to_sym) { kind == k }
    end

    def description_or_file_name
      description? ? description : file_name
    end

    def media(style = nil)
      if image? && !style.blank? && style.to_sym != :original
        size = PushType.config.media_styles[style.to_sym] || style
      end
      size ? file.thumb(size) : file
    end

    def preview_thumb_url(size = '300x300#')
      return nil unless file_stored?
      if image?
        media(size).url
      else
        "push_type/icon-file-#{ kind }.png"
      end
    end

    def as_json(options = nil)
      options = { only: [:id, :file_name, :file_size, :mime_type, :created_at], methods: [:new_record?, :image?, :description_or_file_name, :preview_thumb_url] } if options.empty?
      super(options)
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
