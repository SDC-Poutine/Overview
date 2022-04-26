select json_build_object(
  'id', (select id from product),
  'name', (select name from product),
  'slogan', (select slogan from product),
  'description', (select description from product),
  'category', (select category from product),
  'default_price', (select default_price from product),
  'features', (select json_agg(row_to_json("features")) from "features")
)


SELECT json_build_object(
  'products', (SELECT json_agg(row_to_json("product")) FROM "product" WHERE id = 1),
  'feature', (SELECT json_agg(row_to_json("features")) FROM "features" WHERE product_id = 1)
)
^
 {"products" : [{"id":1,"name":"Camo Onesie","slogan":"Blend in to your crowd","description":"The So Fatigues will wake you up and fit you in. This high energy camo will have you blending in to even the wildest surroundings.","category":"Jackets","default_price":"140"}], "feature" : [{"id":1,"product_id":1,"feature":"Fabric","value":"Canvas"}, {"id":2,"product_id":1,"feature":"Buttons","value":"Brass"}]}
(1 row)




SELECT json_build_object(
  'id', (SELECT id FROM product WHERE id = 1),
  'name', (SELECT name FROM product WHERE id = 1),
  'slogan', (SELECT slogan FROM product WHERE id = 1),
  'description', (SELECT description FROM product WHERE id = 1),
  'category', (SELECT category FROM product WHERE id = 1),
  'features', (SELECT json_agg(row_to_json("features")) FROM "features" WHERE product_id = 1)
);

SELECT json_build_object(
  'product_id', (SELECT productId FROM styles WHERE style_id = 1),
  'results', (SELECT json_agg(row_to_json(styles)) FROM (SELECT style_id, name, original_price, sale_price, default_style from "styles" WHERE productId = 1),
  'photos', (SELECT json_agg(row_to_json(photos)) FROM (SELECT url FROM "photos" WHERE styleId = 1) photos) AS URL styles)
);




SELECT row_to_json(products1) FROM (SELECT id, name, description FROM "product") AS products1 WHERE id = 1;


SELECT json_build_object(
  'product_id', (
    SELECT productId FROM styles WHERE style_id = 1
    ),
  'results', (
    SELECT json_agg(row_to_json(styles)) FROM (SELECT style_id, name, original_price, sale_price, default_style from "styles" WHERE productId = 1) AS styles, (
      SELECT json_agg(row_to_json(photos)) FROM (SELECT url from "photos" WHERE styleId = 1) AS photos
    )
    )
);

```
--------------------------------------------
SELECT json_build_object(
  'product_id', (
    SELECT productId FROM styles WHERE style_id = 1
    ),
  'results', (
    SELECT json_agg(json_build_object(
		'style_id', (
			SELECT style_id FROM styles WHERE style_id = 1
				),
		'name', (
			SELECT name FROM styles WHERE style_id = 1
				),
		'original_price', (SELECT original_price FROM styles WHERE style_id = 1
				),
		'sale_price', (SELECT sale_price FROM styles WHERE style_id = 1
				),
		'default?', (SELECT default_style FROM styles WHERE style_id = 1
				),
		'photos', (
			SELECT json_agg(row_to_json("photos")) FROM "photos" WHERE styleId = 1


				)
			)
		)
    )
);
```
```
-----------------------------------------------
SELECT row_to_json(t)
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
  FROM product AS p WHERE p.id = 3
 ) t

 ```