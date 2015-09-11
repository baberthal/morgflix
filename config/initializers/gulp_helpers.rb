require './lib/gulp_helpers/lib/gulp_helpers'

module GulpHelpers
  if Rails.env.production?
    class << self
      rev_manifest_path = 'public/assets/rev-manifest.json'

      if File.exist?(rev_manifest_path)
        REV_MANIFEST = JSON.parse(File.read(rev_manifest_path))
      end
    end
  end
end

helpers = 'include GulpHelpers::Helpers'
ActionView::Base.module_eval(helpers)
Rails.application.assets.context_class.class_eval(helpers)
