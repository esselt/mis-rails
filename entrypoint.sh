#!/bin/sh

# Precompile assets
bundle exec rake assets:precompile

# Run Puma/Rails server
bundle exec puma -C config/puma.rb