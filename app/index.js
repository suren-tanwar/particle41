const express = require('express');
const os = require('os');

const app = express();
const PORT = process.env.PORT || 8080;

function getClientIP(req) {
  return (
    req.headers['x-forwarded-for']?.split(',')[0] ||
    req.socket.remoteAddress
  );
}

app.get('/', (req, res) => {
  res.json({
    timestamp: new Date().toISOString(),
    ip: getClientIP(req),
  });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
