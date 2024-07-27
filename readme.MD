1. Install Docker

If you haven't already installed Docker on macOS, download and install Docker Desktop from the official Docker website. Follow the installation instructions provided.
2. Pull the PostgreSQL Docker Image

Open a terminal and pull the PostgreSQL image from Docker Hub:

bash

docker pull postgres

3. Run the PostgreSQL Container

Run a PostgreSQL container with the following command:

bash

docker run --name rust-crud-container -e POSTGRES_USER=rustdb -e POSTGRES_PASSWORD=rustdb -e POSTGRES_DB=rustcrud -p 5432:5432 -d postgres

    --name postgres-container: Assigns a name to the container.
    -e POSTGRES_USER=myuser: Sets the PostgreSQL username.
    -e POSTGRES_PASSWORD=mypassword: Sets the PostgreSQL password.
    -e POSTGRES_DB=mydatabase: Creates a database named mydatabase.
    -p 5432:5432: Maps port 5432 on your host to port 5432 on the container.
    -d: Runs the container in detached mode.
    postgres: Specifies the image to use.

4. Verify the Container is Running

Check that the container is running:

bash

docker ps

You should see your PostgreSQL container in the list.
5. Connect to PostgreSQL from Your Rust Application

    Update .env File

    Update your .env file with the following connection URL:

    dotenv
docker run --name rust-crud-container -e POSTGRES_USER=rustdb -e POSTGRES_PASSWORD=rustdb -e POSTGRES_DB=rustcrud -p 5432:5432 -d postgres
DATABASE_URL=postgres://rustdb:rustdb@localhost:5432/rust-crud-container 

Ensure that myuser, mypassword, and mydatabase match the values used when starting the container.

Initialize Database Connection in Rust

Use the same initialization code as before in your main.rs or lib.rs:

rust

use actix_web::{web, App, HttpServer};
use sqlx::postgres::PgPoolOptions;
use dotenv::dotenv;
use std::env;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    dotenv().ok();  // Load environment variables from `.env`

    let database_url = env::var("DATABASE_URL")
        .expect("DATABASE_URL must be set");

    let pool = PgPoolOptions::new()
        .max_connections(5)
        .connect(&database_url)
        .await
        .expect("Failed to create pool");

    HttpServer::new(move || {
        App::new()
            .app_data(web::Data::new(pool.clone()))
            .service(
                // Define your routes here
            )
    })
    .bind("127.0.0.1:8080")?
    .run()
    .await
}

Create Database Tables

Connect to the PostgreSQL container using psql or a graphical tool:

Using psql

    First, find the container ID:

    bash

docker ps

Connect to the container:

bash
DATABASE_URL=postgres://rustdb:rustdb@localhost:5432/rust-crud-container
docker exec -it rust-crud-container psql -U rustdb -d rustcrud

Create tables:

sql

        CREATE TABLE contents (
            id SERIAL PRIMARY KEY,
            user_id VARCHAR(255),
            user_name VARCHAR(255),
            user_image TEXT,
            content TEXT,
            content_img TEXT,
            media_type VARCHAR(50),
            content_time TIMESTAMPTZ,
            saves INTEGER DEFAULT 0,
            likes INTEGER DEFAULT 0,
            comments INTEGER DEFAULT 0,
            share INTEGER DEFAULT 0,
            location VARCHAR(255)
        );

        CREATE TABLE videos (
            id SERIAL PRIMARY KEY,
            user_id VARCHAR(255),
            user_name VARCHAR(255),
            user_image TEXT,
            content_video TEXT,
            content_time TIMESTAMPTZ,
            views INTEGER DEFAULT 0,
            likes INTEGER DEFAULT 0,
            saves INTEGER DEFAULT 0,
            comments INTEGER DEFAULT 0,
            share INTEGER DEFAULT 0,
            location VARCHAR(255)
        );

    Using pgAdmin
        Install pgAdmin if you prefer a graphical tool.
        Configure pgAdmin to connect to the PostgreSQL instance running in the Docker container (host localhost, port 5432, and credentials set previously).

Summary

    Install Docker Desktop and run the PostgreSQL container with the specified credentials.
    Connect your Rust application using the DATABASE_URL environment variable.
    Create the necessary database tables using psql or a graphical tool like pgAdmin.

This setup will allow you to work with PostgreSQL in a containerized environment on macOS, making it easy to manage and deploy your database alongside your application.