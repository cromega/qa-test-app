# Test Site

## Dependencies

```sh
sudo apt-get install build-essential sqlite3 libsqlite3-dev
bundle install
```

if `bundle` is missing:

```sh
gem install bundler
```

## Running

### Preparing the database

```sh
bundle exec rake db:migrate
```

### Launch the site

```sh
bundle exec rails server
```

Visit http://localhost:3000

## Running unit tests

```sh
bundle exec rspec
```

