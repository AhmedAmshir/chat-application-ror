[![](https://img.shields.io/badge/Chat_System-red?style=for-the-badge)](https://docs.rs/crate/redant/latest)
[![](https://img.shields.io/badge/Api-yellow?style=for-the-badge)](https://docs.rs/crate/redant/latest)

# Prerequisite

- Docker and docker compose for containerize the application.
- Ruby on rails V5.
- MySQL as a datastore.
- ElasticSearch for searching through messages of a specific chat.
- RabbitMQ and Sneakers to avoid race conditions.
- Whenever to create a cronjob for updating chats and messages counts.
- RSpec as a testing framework 

# How to run the Application
- Clone the repo
``` sh
git clone https://github.com/ahmedamshir/chat-application-ror.git
```
- All you need to run this command to build and start the application
``` sh
docker-compose up -d --build
```
- The application will launch on port 3001
``` sh
http://localhost:3001
```
- You can find all endpoints docs here
[![Run in Postman](https://run.pstmn.io/button.svg)](https://documenter.getpostman.com/view/19109979/2s7YYpfRHq#intro)

- You can run tests by this command from inside the container
``` sh
docker exec -it app_container bash
rspec spec/models/application_spec.rb -f d
```