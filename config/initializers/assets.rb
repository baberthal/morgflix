# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

Rails.root.join('vendor', 'assets', 'bower_components').to_s.tap do |bower_path|
  Rails.application.config.sass.load_paths << bower_path
  Rails.application.config.assets.paths << bower_path
end

public_assets = Rails.root.join('public', 'assets')
Rails.application.config.assets.paths << public_assets.join('stylesheets')
Rails.application.config.assets.paths << public_assets.join('javascripts')

twbs = %r{bootstrap-sass/assets/fonts/bootstrap/[\w-]+\.(?:eot|svg|ttf|woff2?)$}
Rails.application.config.assets.precompile << twbs

number_precision = [8, ::Sass::Script::Value::Number.precision].max
::Sass::Script::Value::Number.precision = number_precision

# Rails.application.config.assets.paths << Emoji.images_path
# Rails.application.config.assets.precompile += %w( search.js )
