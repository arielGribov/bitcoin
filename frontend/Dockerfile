# Use an official Nginx image to serve the static files
FROM nginx:alpine

# Copy the frontend files into the container
COPY ./ /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

# Expose the default Nginx port
EXPOSE 80


