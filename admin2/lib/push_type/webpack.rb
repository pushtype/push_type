module PushType
  class Webpack

    class_attribute :instance
    attr_accessor :manifest

    def self.load
      self.instance = new
    end

    def self.lookup(name)
      load if Rails.env.development?
      raise "PushType::Webpack.load must be called first" unless instance
      instance.manifest[name.to_s] || raise("Can't find #{name} in #{file_path}. Is webpack still compiling?")
    end

    def initialize
      @manifest = load manifest_path
    end

    private

    def root_path
      PushType::Admin::Engine.root
    end

    def manifest_path
      root_path.join 'public', 'packs', 'manifest.json'
    end

    def load(path)
      return {}.freeze unless File.exist?(path)
      JSON.parse(File.read(path))
    end

  end
end