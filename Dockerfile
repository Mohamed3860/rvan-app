FROM ghcr.io/cirruslabs/flutter:stable AS build
WORKDIR /app
COPY . .
RUN flutter config --enable-web
RUN flutter create . --platforms web
RUN flutter pub get
RUN flutter build web --release --no-tree-shake-icons
FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
