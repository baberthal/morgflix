Rails.application.config.assets.version = '1.0'

public_assets = Rails.root.join('public', 'assets')
Rails.application.config.assets.paths << public_assets.join('stylesheets')
Rails.application.config.assets.paths << public_assets.join('javascripts')

