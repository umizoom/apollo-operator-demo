import { ApolloServer } from "@apollo/server";
import { ApolloServerPluginCacheControl } from "@apollo/server/plugin/cacheControl";
import { startStandaloneServer } from "@apollo/server/standalone";
import { getReviewsSchema } from "./subgraph.js";

async function startServer() {
  // Get the built subgraph schema
  const schema = getReviewsSchema();

  // Create Apollo Server instance
  const server = new ApolloServer({
    schema,
    // Enable Apollo Studio introspection and playground in production
    introspection: true,
    playground: true,
    plugins: [
      ApolloServerPluginCacheControl({
        // Don't send the `cache-control` response header.
        calculateHttpHeaders: true,
      }),
    ],
  });

  // Start the server
  const { url } = await startStandaloneServer(server, {
    listen: { port: process.env.PORT || 4000, host: "0.0.0.0" },
  });

  console.log(`🚀 Reviews subgraph ready at ${url}`);
  console.log(`🔍 GraphQL Playground available at ${url}`);
}

// Handle graceful shutdown
process.on("SIGINT", () => {
  console.log("\n👋 Shutting down server...");
  process.exit(0);
});

process.on("SIGTERM", () => {
  console.log("\n👋 Shutting down server...");
  process.exit(0);
});

// Start the server
startServer().catch((error) => {
  console.error("❌ Error starting server:", error);
  process.exit(1);
});
