# https://github.com/asciinema/asciinema.org/blob/master/docs/INSTALL.md
git clone --recursive https://github.com/asciinema/asciinema.org.git .
git checkout -b my-company
# editing .env.production and docker-compose.yml config files
docker-compose run --rm web mix phx.gen.secret
# get SECRET_KEY_BASE and write it into .env.production
docker-compose up -d postgres
docker-compose run --rm web setup
docker-compose up -d
