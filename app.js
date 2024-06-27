const express = require('express');
const os = require('os');
const app = express();
const port = 4000;

// // Middleware to log incoming requests
// app.use((req, res, next) => {
//   // Log incoming request details
//   console.log(`[${new Date().toISOString()}] Received request on ${os.hostname()} from ${req.ip}`);
//   next();
// });

app.get('/', (req, res) => {
  res.send(`[${new Date().toISOString()}] Received request on ${os.hostname()} from ${req.ip}`);
});

app.listen(port, () => {
  console.log(`Node.js app listening at http://localhost:${port}`);
});
