# Use the official Node.js 18 image.
# https://hub.docker.com/_/node
FROM node:alpine

# Create and change to the app directory.
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
# If you're using npm workspaces or other setups, you might need to adjust this.
COPY package*.json ./

# Install all dependencies, including development ones.
RUN npm install

# Copy local code to the container image.
COPY . .

# The command to run your application in development mode.
CMD [ "npm", "run", "dev" ]
