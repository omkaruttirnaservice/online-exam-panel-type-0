require('dotenv').config();
const mysql = require('mysql2/promise');
const fs = require('fs').promises;
const path = require('path');

async function loadDatabase() {
    let connection;
    try {
        // First create connection without database selected
        connection = await mysql.createConnection({
            host: process.env.DB_HOST || 'localhost',
            user: process.env.DB_USER || 'root',
            password: process.env.DB_PASSWORD,
            port: process.env.DB_PORT || 3306,
            multipleStatements: true,
        });

        // Create database if it doesn't exist
        const dbName = process.env.DB_DATABASE;
        await connection.query(`CREATE DATABASE IF NOT EXISTS ${dbName}`);
        console.log(`Ensured database ${dbName} exists`);

        // Select the database
        await connection.query(`USE ${dbName}`);

        // Read the SQL file
        const sqlFilePath = path.join(__dirname, 'database-create-statments.sql');
        const sqlContent = await fs.readFile(sqlFilePath, 'utf8');

        // Execute the entire SQL file
        await connection.query(sqlContent);
        console.log('Database schema and data loaded successfully');

        // Close connection
        await connection.end();
        console.log('Database setup completed');
        process.exit(0);
    } catch (error) {
        console.error('Error loading database:', error);
        if (connection) {
            await connection.end();
        }
        process.exit(1);
    }
}

loadDatabase();
