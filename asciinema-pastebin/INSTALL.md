# https://github.com/asciinema/asciinema.org/blob/master/docs/INSTALL.md
# https://asciinema.org/a/WDgST2gmFFIxlpUxvUWbZAqYr
git clone --recursive https://github.com/asciinema/asciinema.org.git .
git checkout -b my-company
# editing .env.production and docker-compose.yml config files
docker-compose run --rm web mix phx.gen.secret
# get SECRET_KEY_BASE and write it into .env.production
docker-compose up -d postgres
docker-compose run --rm web setup
docker-compose up -d

# Using asciinema recorder with your instance

echo "[api]\nurl = http://asciinema.private" > ~/.asciinema/config
