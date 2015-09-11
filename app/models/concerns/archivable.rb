module Archivable
  extend ActiveSupport::Concern

  module ClassMethods
    attr_accessor :base_dir

    def base_dir
      @base_dir ||= Rails.root.join('public', 'assets', 'media', 'series')
    end

    def base_dir=(*new_base_dir)
      @base_dir = Rails.root.join(new_base_dir.join('/'))
    end
  end
end
