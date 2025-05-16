// server.js
import { serve } from "bun";

const port = process.argv[2]
const name = process.argv[3]
serve({
  port,
  fetch(req) {
    const { method, url, headers } = req;
    const bodyPromise = req.text();

    return bodyPromise.then((body) => {
      const response = {
        method,
        url,
        headers: Object.fromEntries(headers),
        body,
      };
      return new Response(`Hello from ${name}\n`);
    });
  },
});

console.log(`Server running on http://localhost:/${port} via ${name}`);
