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

pool.query('SELECT NOW()', (err, res) => {
  console.log(err, res)
  pool.end()
})

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