const http = require('http');
const os = require('os');

console.log("Starting a simple HTTP server...");

const handler = (request, response) => {
  console.log("Received a request from " + request.connection.remoteAddress);
  response.writeHead(200);
  response.end(`Hello from a containerized application! Host: ${os.hostname()}\n`);
};

const www = http.createServer(handler);
www.listen(8080);