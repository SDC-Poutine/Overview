require('dotenv').config();
const { Pool, Client } = require('pg')

const pool = new Pool({
  host: process.env.HOST,
  user: process.env.USER,
  password: process.env.PASSWORD,
  database: 'overview',
  port: process.env.PGPORT
})

pool.connect()

module.exports = {
  query: (text, callback) => {
    const start = Date.now()
    return pool.query(text, (err, res) => {
      const duration = Date.now() - start;
      console.log('executed query', { text, duration })
      if (err) {
        callback(err, null);
      } else {
        callback(null, res);
      }
    })
  }
}

// const client = new Client({
//   host: process.env.HOST,
//   user: process.env.USER,
//   password: process.env.PASSWORD,
//   database: 'overview'
//   port: process.env.PGPORT
// })

// client.connect()

// client.query('SELECT NOW()', (err, res) => {
//   console.log(err, res)
//   client.end()
// })