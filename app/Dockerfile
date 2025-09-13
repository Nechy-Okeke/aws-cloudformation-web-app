# Stage 1: Build a production-ready Node.js image
FROM node:18-alpine AS build
WORKDIR /app
COPY package.json ./
RUN npm install --production

# Copy the application source code
COPY . .

# Stage 2: Create a minimal final image
FROM node:18-alpine
WORKDIR /app
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/index.js .

# Expose the port the app listens on
EXPOSE 8080
CMD ["node", "index.js"]