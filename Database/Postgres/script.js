import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
  insecureSkipTLSVerify: true,
  noConnectionReuse: false,
  stages: [
    { duration: '15s', target: 100 },
    { duration: '30s', target: 100 },
    { duration: '60s', target: 0 }
  ]
};

export default function () {
  const BASE_URL = 'http://localhost:3030'; // make sure this is not production

  const responses = http.batch([
    ['GET', `${BASE_URL}/product?product_id=${Math.floor(Math.random() * 1000011)}`],
  ]);

  sleep(0.1);
}
