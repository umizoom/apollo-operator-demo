# Use Node.js 22 Alpine for smaller image size
FROM node:22-alpine

# Install wget for health checks
RUN apk add --no-cache wget

# Set working directory
WORKDIR /app

# Copy package.json first to leverage Docker cache
COPY package.json ./

# Install dependencies
RUN npm install --omit=dev && npm cache clean --force

# Copy application files
COPY . .

# Create non-root user for security
RUN addgroup -g 1001 -S nodejs && \
    adduser -S reviews -u 1001 && \
    chown -R reviews:nodejs /app

# Switch to non-root user
USER reviews

# Expose the port
EXPOSE 4000

# Health check to ensure the GraphQL server is running
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q --spider --post-data='{"query":"query { __typename }"}' --header='Content-Type: application/json' http://localhost:4000/ || exit 1

# Start the application
CMD ["npm", "start"]
