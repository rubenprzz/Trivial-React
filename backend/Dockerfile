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