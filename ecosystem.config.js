module.exports = {
    apps: [
        {
            name: 'online-exam-panel',
            script: './bin/www',

            // Options reference: https://pm2.io/doc/en/runtime/reference/ecosystem-file/
            instances: 1,
            autorestart: true,
            watch: false,
            max_memory_restart: '2G',
            env: {
                PROJECT_ENV: 'development',
            },
            env_production: {
                PROJECT_ENV: 'production',
            },
        },
    ],
};
