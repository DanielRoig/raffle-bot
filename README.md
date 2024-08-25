# RAILS_API_BOILERPLATE


## Requirements
- Ruby 3.1.2
- Ruby on Rails 7.0.3
- Postgres
- Redis

## Done
- Endpoints with grape covered with tests
- Models covered with tests
- Services covered with tests
- Workers using sidekiq covered with tests
- Mailer
- Error handler
- Initial seed
- Rake test task
- Docker integration
- Swagger

## Installation
1. Replace all matches with `RAILS_API_BOILERPLATE`, `rails_api_boilerplate`,  `RailsApiBoilerplate` and `rails-api-boilerplate` to desired name 
2. Set `.env.local` with correct params
3. Run:
```ruby
bundle install
```

### Run server
In two diferent consoles run:
```ruby
bundle exec sidekiq start
```
```ruby
rails s 
```
or
```ruby
rails server -p 3000
```
### Run tests
```ruby
rails spec exec "path:line"
```
### Run rubocop autofix
```ruby
rubocop -a "path"
```
### Run console 
```ruby
rails c
```
### Run migration
```ruby
rails db:migrate RAILS_ENV=development
```
### Run task
```ruby
rake task_name
```

## Util comands
### Reset DB
```ruby
rails db:drop db:create db:migrate db:seed_fu RAILS_ENV=test
```
### Force from console execute Job
[Stackoverflow](https://stackoverflow.com/questions/44144686/why-isnt-my-rails-worker-executing
)
```ruby
DonationMailerWorker.new.perform(Donation.last.id)
```
### Start quick
```bash
./start.sh
```

Give permissions
```bash
chmod +x start.sh
```
### Others
```ruby
rails generate model Comment commenter:string body:text article:references
```

```ruby
rails generate controller Comments
```
```ruby
rails g scaffold company name:string city:string
```

## Swagger
http://localhost:3000/v1/swagger_doc
https://petstore.swagger.io/

## Docker
```bash
docker-compose build
```
```bash
docker-compose up
```