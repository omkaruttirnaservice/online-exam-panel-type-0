const dumpModel = {
    cleanExsistingDb: (pool, databaseName) => {
        return new Promise((resolve, reject) => {
            const tables = `
        SELECT table_name 
        FROM information_schema.tables
        WHERE table_schema = ?
        `;

            pool.query(tables, databaseName, async function (err, result) {
                if (err) {
                    reject(err);
                    return;
                }

                const tables = result;
                console.log({ tables });
                if (tables.length === 0) {
                    console.log('No tables found');
                    // return reject('No tables found');
                    resolve('No tables found, skipping table remove');
                } else {
                    console.log('Info: Dropping tables started');
                    await dumpModel.dropAllTable(pool, tables);
                    console.log('Info: Dropping tables completed');

                    resolve('Completed dropping all tables');
                }
            });
        });
    },

    async dropAllTable(pool, tables) {
        for (const table of tables) {
            await dumpModel.dropTable(pool, table.TABLE_NAME);
        }
    },

    dropTable(pool, table) {
        return new Promise((resolve, reject) => {
            const q = `DROP TABLE IF EXISTS ${table}`;
            console.log({ q });
            pool.query(q, function (err, result) {
                if (err) return reject(err);
                resolve(result);
            });
        });
    },
};

module.exports = dumpModel;
