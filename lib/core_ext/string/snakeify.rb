class String
  def snakeify!
    first_pass = /([A-Z]+)([A-Z][a-z])/
    second_pass = /([a-z\d])([A-Z])/
    gsub!(first_pass, '\1_\2') || gsub(first_pass, '\1_\2')
    gsub!(second_pass, '\1_\2') || gsub(second_pass, '\1_\2')
    tr!('-', '_')
    downcase!
  end

  def snakeify
    dup.tap(&:snakeify!)
  end
end
