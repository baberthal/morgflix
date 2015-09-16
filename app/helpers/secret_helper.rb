module SecretHelper
  def default_banner
    rand = %w(blue cyan deep_orange light_blue pink purple red teal).sample
    "/assets/images/default_banners/#{rand}.png"
  end
end
