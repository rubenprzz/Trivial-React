# Multi-stage build for an Express (Node.js) and React application

# --- Stage 1: Build React Application ---
# Use the official Node.js image for building the React application.
FROM node:22.12.0 AS react-build

# Set the working directory inside the container.
WORKDIR /app

# Copy only the package.json and package-lock.json files for the React app to install dependencies first.
COPY ./frontend/package*.json ./frontend/

# Move to the React app directory and install dependencies.
WORKDIR /app/frontend
RUN npm install

# Copy the rest of the React app source files to the working directory.
COPY ./frontend ./frontend/

# Build the React app for production. The build output will be in the 'build' folder.

# --- Stage 2: Serve React app with serve ---
FROM node:22.12.0

# Set the working directory inside the container for the server.
WORKDIR /app

# Install `serve` globally.
RUN npm install -g serve

# Copy the build output from the previous stage.
COPY --from=react-build /app/frontend/build ./build

# Expose the port that serve will listen on (3001 in this case).
EXPOSE 3001

# Define the command to run the app using `serve`.
CMD ["serve", "-l", "3001", "-s", "build"]

# --- Stage 2: Set up Express server ---
# Use another Node.js image for the backend server.
FROM node:22.12.0

# Set the working directory inside the container for the server.
WORKDIR /app

# Copy only the package.json and package-lock.json files for the Express server to install dependencies first.
COPY ./backend/package*.json ./backend/

# Move to the server directory and install dependencies.
WORKDIR /app/backend
RUN npm install

# Copy the built React application into the 'public' directory of the Express server.
# This allows the server to serve the React app's static files.
COPY --from=react-build /app/frontend/build ./public

# Copy the rest of the Express server source files to the working directory.
COPY ./backend ./backend

# Expose the port that the server will run on (3000 by default).
EXPOSE 3000

# Define the command to start the Express server.
CMD ["node", "index.js"]

# --- Add PostgreSQL Service ---
# Use the official PostgreSQL image for the database service.
FROM postgres:16 AS postgres

# Set environment variables for PostgreSQL. Replace values as needed.
ENV POSTGRES_USER=trivial_user
ENV POSTGRES_PASSWORD=trivial_password
ENV POSTGRES_DB=trivial_db

# Expose the PostgreSQL default port.
EXPOSE 5432