# Use official Nginx image
FROM nginx:alpine

# Remove default HTML files
RUN rm -rf /usr/share/nginx/html/*

# Copy our static site to Nginx default path
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80
