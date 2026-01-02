const express = require('express');
const path = require('path');
const app = express();
const PORT = process.env.PORT || 3000; // Use port 3000 or an environment variable

// Serve static files from the 'build/web' directory
app.use(express.static(path.join(__dirname, '../build/web')));

// Handle all other routes by serving the index.html file (essential for Flutter routing)
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '../build/web', 'index.html'));
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
