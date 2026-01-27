FROM nginx:alpine

# Default nginx html remove pannum
RUN rm -rf /usr/share/nginx/html/*

# Namma website files copy pannum
COPY index.html /usr/share/nginx/html/

# Container start aagumbodhu nginx run aagum
CMD ["nginx", "-g", "daemon off;"]
