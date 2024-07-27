Rust API with Actix-Web

This project is a RESTful API built with Rust, using the Actix-Web framework and Postgres DB. The API is dockerized for easy deployment and management.
Endpoints
Contents

    GET /contents - Retrieve a list of all contents.
    GET /content/{id} - Retrieve a specific content by its ID.
    POST /content/{id}/like - Like a specific content by its ID.
    POST /content/{id}/save - Save a specific content by its ID.
    POST /content/{id}/share - Share a specific content by its ID.
    DELETE /content/{id}/delete - Delete a specific content by its ID.

Videos

    GET /videos - Retrieve a list of all videos.
    GET /video/{id} - Retrieve a specific video by its ID.
    POST /video/{id}/like - Like a specific video by its ID.
    POST /video/{id}/view - View a specific video by its ID.

Users

    GET /users - Retrieve a list of all users.
    GET /user/{id} - Retrieve a specific user by their ID.

Chats

    GET /chat/{id} - Retrieve a specific chat by its ID.
    POST /chats - Create a new chat.

Prerequisites

    Docker
    Docker Compose

Getting Started
Clone the repository

bash

git clone https://github.com/yourusername/rust-api-dockerized.git
cd rust-api-dockerized

Build and Run the Docker Containers

bash

docker-compose up --build

This command will build the Docker image and start the containers defined in the docker-compose.yml file.
Accessing the API

Once the containers are up and running, the API will be accessible at http://localhost:8080.
Database Configuration

This project uses PostgreSQL as the database. The database configuration can be found in the docker-compose.yml file. You can modify the settings as needed.
Running Migrations

Before starting the API, ensure that the database schema is up to date by running the migrations:

bash

docker-compose run --rm app cargo sqlx migrate run

Environment Variables

The API uses environment variables for configuration. You can find the environment variable definitions in the docker-compose.yml file. Update these variables as necessary to match your setup.
Project Structure

    src/ - Contains the source code for the API.
    migrations/ - Contains the database migrations.
    Dockerfile - Defines the Docker image for the API.
    docker-compose.yml - Defines the Docker services for the application.

Contributing

If you'd like to contribute to this project, please fork the repository and use a feature branch. Pull requests are welcome.
License

This project is licensed under the MIT License.