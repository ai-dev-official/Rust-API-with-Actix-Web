# Use the official Rust image as the base
FROM rust:latest

# Enable sqlx offline mode for docker build
# ARG SQLX_OFFLINE=true

# Set the working directory inside the container
WORKDIR /app

# Copy your Rust project files (Cargo.toml and src/) into the container
COPY . .

# Build your Rust project
RUN cargo build --release

# Expose the port your API will listen on
EXPOSE 8080

# Start your API when the container runs
CMD ["./target/release/backend"]
