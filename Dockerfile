# Dockerfile for package.json

# Use the official Node.js image from the Docker Hub as the base image
FROM node:16 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Build stage
FROM node:16

# Set the working directory inside the container
WORKDIR /app

# Copy the necessary files from the build stage
COPY --from=build /app ./

# Expose the port the app runs on
EXPOSE 3000

# Command to run the app
CMD ["node", "server.js"]