
# Use the official Rust image as the build stage
FROM rust:latest as builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Cargo.toml and Cargo.lock files first
COPY Cargo.toml Cargo.lock ./

# Create a dummy main.rs to build the dependencies
RUN mkdir src && echo "fn main() {}" > src/main.rs

# Build only the dependencies to cache them
RUN cargo build --release

# Remove the dummy main.rs
RUN rm -rf src

# Copy the rest of your Rust project files
COPY . .

# Build your Rust project
RUN cargo build --release

# Use a minimal image for the final stage
FROM debian:buster-slim

# Install required libraries for running the Rust binary
RUN apt-get update && apt-get install -y libssl1.1 ca-certificates && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy the built binary from the builder stage
COPY --from=builder /app/target/release/backend .

# Expose the port your API will listen on
EXPOSE 8080

# Start your API when the container runs
CMD ["./backend"]




