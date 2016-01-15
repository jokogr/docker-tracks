#!/bin/bash
set -e

cd /usr/local/share/tracks

bundle exec rake db:migrate RAILS_ENV=production
bundle exec rake assets:precompile RAILS_ENV=production

TRACKS_FORCE_SSL=${TRACKS_FORCE_SSL:-false}

for variable in TRACKS_SALT TRACKS_SECRET_TOKEN TRACKS_ADMIN_EMAIL \
  TRACKS_FORCE_SSL; do
    sed -ri "s/[{]{2}$variable[}]{2}/\${$variable}/g" config/site.yml
done

exec /usr/bin/supervisord -nc /etc/supervisor/supervisord.conf

exit 0
