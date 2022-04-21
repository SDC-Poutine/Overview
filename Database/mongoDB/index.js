const mongoose = require('mongoose');
mongoose.connect('mongodb://localhost:27017/overview', (err) => {
  if (err) {
    console.log(err);
    return;
  }
  console.log('connected to mongo')
})

const product = new mongoose.Schema({
  id: Number,
  name: String,
  slogan: String,
  description: String,
  category: String,
  default_price: String,
})

const features = new mongoose.Schema({
  features: [{feature: String, value: String}],
})

const styles = new mongoose.Schema({
  product_id: Number,
  result: [{
    style_id: Number,
    name: String,
    original_price: String,
    sale_price: String,
    default?: Boolean,
    photos: [{thumbnail_url: String, url: String}],
  }],
  skus: {
    sku_id: {quantity: Number, size: String},
  }
})

