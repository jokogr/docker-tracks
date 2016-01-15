#!/bin/bash
set -e

cd /usr/local/share/tracks

bundle exec rake db:migrate RAILS_ENV=production
bundle exec rake assets:precompile RAILS_ENV=production

TRACKS_SECRET_TOKEN=${TRACKS_SECRET_TOKEN:-$(bundle exec rake secret)}
TRACKS_FORCE_SSL=${TRACKS_FORCE_SSL:-false}

exec /usr/bin/supervisord -nc /etc/supervisor/supervisord.conf

exit 0
