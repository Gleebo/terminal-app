if `gem list bundler -i`; then
  bundle
else
  gem install bundle
  bundle
  echo "ready to play"
fi