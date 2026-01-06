# Use nginx image
FROM nginx:alpine

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy our html file
COPY index.html /usr/share/nginx/html/

# Expose port
EXPOSE 80
