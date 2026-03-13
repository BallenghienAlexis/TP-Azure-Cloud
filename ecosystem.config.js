module.exports = {
  apps: [{
    name: 'cloud-lab',
    script: 'server.js',
    watch: true,
    ignore_watch: ['node_modules', 'dist', 'logs'],
    env: {
      NODE_ENV: 'production',
      PORT: 3000
    }
  }]
};

