# MINDSPARK ELITE: DOCKER IMAGE
FROM ubuntu:20.04 AS build-env

RUN apt-get update && apt-get install -y curl git unzip xz-utils zip libglu1-mesa
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web

# Copy your GitHub code into the container
WORKDIR /app
COPY . .
RUN flutter pub get
RUN flutter build web --release

# Serve the app using an ultra-fast Nginx web server
FROM nginx:alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD["nginx", "-g", "daemon off;"]