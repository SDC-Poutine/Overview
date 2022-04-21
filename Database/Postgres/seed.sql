\c overview;

\COPY product FROM '/Users/home/Desktop/csv/product.csv' delimiter ',' csv header;

\COPY features FROM '/Users/home/Desktop/csv/features.csv' delimiter ',' csv header;

\COPY styles FROM '/Users/home/Desktop/csv/styles.csv' delimiter ',' csv header;

\COPY photos FROM '/Users/home/Desktop/csv/photos.csv' delimiter ',' csv header;

\COPY skus FROM '/Users/home/Desktop/csv/skus.csv' delimiter ',' csv header;