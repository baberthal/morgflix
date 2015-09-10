require_relative 'helpers/util'
require_relative 'helpers/asset_tag_helper'

module GulpHelpers
  module Helpers
    def self.included(base)
      base.include(AssetTagHelper)
    end

    def self.extended(base)
      base.extend(AssetTagHelper)
    end
  end
end
