require('dotenv').config();
const express = require('express');
const app = express();
const db = require('../Database/Postgres/index.js')

const port = process.env.PORT || 3000;

app.use(express.json());

app.get('/', (req, res) => {
  res.send('Hello World!')
})

//retrieve all data
app.get('/products', (req, res) => {
  db.query(`SELECT * FROM product`, null, (err, result) => {
    if (err) {
      res.send(err);
    } else {
      res.send(result.rows);
    }
  })
})

//retrieve single product data
app.get('/product', (req, res) => {
  db.query(`SELECT json_build_object(
    'id', (SELECT id FROM product WHERE id = ${req.query.product_id}),
    'name', (SELECT name FROM product WHERE id = ${req.query.product_id}),
    'slogan', (SELECT slogan FROM product WHERE id = ${req.query.product_id}),
    'description', (SELECT description FROM product WHERE id = ${req.query.product_id}),
    'category', (SELECT category FROM product WHERE id = ${req.query.product_id}),
    'default_price', (SELECT default_price FROM product WHERE id = ${req.query.product_id}),
    'features', (SELECT json_agg(row_to_json("features")) FROM "features" WHERE product_id = ${req.query.product_id})
  )`, (err, result) => {
    if (err) {
      res.send(err);
    } else {
      res.send(result.rows[0].json_build_object);
    }
  })
})

//retrieve style
app.get('/productStyle', (req, res) => {
  db.query(`SELECT row_to_json(t)
  from (
  SELECT p.id AS product_id,
    (SELECT json_agg(t2) FROM
      (SELECT styles.style_id AS style_id,
     styles.name, styles.original_price, styles.sale_price,
        styles.default_style AS "default?",
        (SELECT json_agg(t3) FROM
          (SELECT photos.thumbnail_url, photos.url
          FROM photos where photos.styleId = styles.style_id
          AND styles.productId = p.id
          ) AS t3
        ) AS photos,
        (SELECT jsonb_object_agg(id, key_pair) FROM
          (SELECT
            skus.id,
            (SELECT json_build_object
              ('size', skus.size, 'quantity', skus.quantity)
            ) key_pair
            FROM skus INNER JOIN styles
            ON styles.style_id = skus.styleId
            WHERE skus.styleId = styles.style_id
            AND styles.productId = p.id GROUP BY skus.id
          ) AS asdf) AS skus FROM styles where productId = p.id
      ) AS t2
    ) AS results
    FROM product AS p WHERE p.id = ${req.query.product_id}
   ) t`, (err, result) => {
    if (err) {
      res.send(err);
    } else {
      res.send(result.rows[0].row_to_json);
    }
  })
})

//retrieve related products
app.get('/relatedProduct', (req, res) => {
  db.query(`SELECT array_agg(related.related)
  FROM related
  INNER JOIN product
  ON product.id = related.productId
  WHERE product.id = ${req.query.product_id}`, (err, result) => {
    if (err) {
      res.send(err);
    } else {
      res.send(result.rows[0].array_agg);
    }
  })
})

//retrieve list of products added to cart by user
app.get('/cart', (req, res) => {

})

//add product to cart
app.post('/cart', (req, res) => {

})


app.listen(port, () => {
  console.log(`App listening on port ${port}`)
})