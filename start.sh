rails assets:precompile
pkill -9 -f puma
rails server -d
