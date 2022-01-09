const express = require('express');
const process = require('process');

const app = express();
const PORT = 8000;

process.on('SIGTERM', () => {
    console.info("Exiting on SIGTERM...")
    process.exit(0)
});
process.on('SIGINT', () => {
    console.info("Exiting on SIGINT...")
    process.exit(0)
});

app.get('/', (req, res) => res.send('Hello world!'));

app.listen(PORT, () => {
    console.log(`Server is running at https://localhost:${PORT}`);
});
