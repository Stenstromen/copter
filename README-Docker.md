# 🚁 Copter Game - Docker Web Export

This setup automatically builds your Godot game for web and serves it with nginx in a Docker container.

## 🚀 Quick Start

### Option 1: Using Docker Compose (Recommended)
```bash
docker-compose up --build
```

### Option 2: Using Docker directly
```bash
# Build the image
docker build -t copter-game .

# Run the container
docker run -p 8080:80 copter-game
```

### Option 3: Using the build script
```bash
chmod +x build.sh
./build.sh
docker-compose up
```

## 🌐 Access Your Game

Once running, open your browser and go to:
**http://localhost:8080**

## 📁 What's Included

- **Dockerfile**: Multi-stage build that compiles Godot game and serves with nginx
- **nginx.conf**: Optimized nginx configuration for Godot web exports
- **export_presets.cfg**: Godot export settings for web builds
- **docker-compose.yml**: Easy deployment configuration
- **.dockerignore**: Excludes unnecessary files from Docker build

## 🔧 How It Works

1. **Build Stage**: Uses `barichello/godot-ci:4.2.2` to export your game to HTML5/WebAssembly
2. **Serve Stage**: Uses `nginx:alpine` to serve the exported files
3. **Optimization**: Includes gzip compression, proper MIME types, and caching headers
4. **Security**: Adds required headers for modern web browsers (CORS, etc.)

## 🛠️ Customization

### Change Port
Edit `docker-compose.yml` and change the port mapping:
```yaml
ports:
  - "3000:80"  # Game will be at http://localhost:3000
```

### Modify Nginx Settings
Edit `nginx.conf` to customize server behavior, caching, or add SSL.

### Godot Export Settings
Edit `export_presets.cfg` to change export options like:
- Canvas resize policy
- Virtual keyboard support
- Progressive Web App settings

## 🐳 Production Deployment

For production, consider:
1. Using a reverse proxy (like Traefik or nginx proxy manager)
2. Adding SSL/TLS certificates
3. Setting up proper domain names
4. Adding monitoring and logging

## 📋 Requirements

- Docker
- Docker Compose (optional but recommended)

## 🎮 Game Controls

- **Click/Tap** or **Spacebar**: Make the copter fly up
- **Goal**: Avoid hitting the platforms and get the highest score!

---

*Built with ❤️ using Godot Engine and Docker*
