# 🤖 Telegram Bot with Ruby on Rails
This project is a Telegram bot built using Ruby on Rails and the telegram-bot gem. Follow the instructions below to set up and run the bot.

<img src="./screenshots/screenshot-1.png" width="300">
<img src="./screenshots/screenshot-3.png" width="300">
<img src="./screenshots/screenshot-2.png" width="300">

## Requirements
- Docker
- Docker Compose

## Setup
#### 1- Clone the repository
```bash
git clone https://github.com/danielroig/raffle-bot.git
cd raffle-bot
```

#### 2- Update the environment variables
Create a ```.env``` file in the root of your project by copying the ```.env.example``` file. Edit the newly created ```.env``` file to include your Telegram bot token and any other necessary configuration variables.

#### 4- Run Docker Compose
Start the application with Docker Compose:
```bash
docker-compose up
```
