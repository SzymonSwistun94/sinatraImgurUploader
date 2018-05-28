def valid?(filename)
  extensions = %w(.jpg .jpeg .png .gif)
  if extensions.any? {|e| filename.end_with? e}
    true
  else
    false
  end

end
