import { createServer } from 'node:http';

createServer((req, res) => res.end()).listen(8080);
