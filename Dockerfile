# Multi-stage build: First stage for building the Godot game
FROM barichello/godot-ci:4.4.1 AS builder

# Set working directory
WORKDIR /app

# Copy the entire project
COPY . .

# Create the build directory and export the game
RUN mkdir -p ./build && \
    mkdir -p /root/.local/share/godot/export_templates/4.4.1.stable/ && \
    godot --headless --export-release "Web" ./build/index.html --quit

# Second stage: nginx to serve the built game
FROM nginx:alpine

# Copy the built game from the builder stage
COPY --from=builder /app/build /usr/share/nginx/html

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
