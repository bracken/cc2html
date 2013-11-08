guard :bundler do
  watch('Gemfile')
  watch('cc2html.gemspec')
end

guard 'minitest' do
  # with Minitest::Unit
  watch(%r|^test/(.*)\/?(.*)_test\.rb|)
  watch(%r|^lib/ims/cc/(.*?)([^/]+)\.rb|)     { |m| "test/unit/#{m[1]}#{m[2]}_test.rb" }
end
