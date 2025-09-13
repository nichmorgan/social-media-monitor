# Use the official n8n image as base
FROM n8nio/n8n:1.105.2

WORKDIR /home/node/.n8n

# Switch to root to install packages
USER root

# Install curl and postgresql client for workflow management
RUN apk update && apk add --no-cache curl postgresql-client

# Create nodes directory and install community nodes
RUN mkdir -p /home/node/.n8n/nodes
WORKDIR /home/node/.n8n/nodes

# Copy package.json with community nodes dependencies
COPY ./n8n/nodes/package.json ./package.json

# Install community nodes in the correct location
RUN npm install && npm cache clean --force

# Copy workflow files and entrypoint script
COPY ./n8n/flows/ /flows/

# Set permissions for both flows and nodes directories
RUN chmod -R 775 /flows/ && \
    chmod -R 775 /home/node/.n8n/nodes && \
    chown -R node:node /flows/ && \
    chown -R node:node /home/node/.n8n/

# Reset working directory
WORKDIR /home/node/.n8n

# Switch back to the node user
USER node