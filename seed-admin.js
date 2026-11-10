// Seeds the first admin from ADMIN_EMAIL / ADMIN_PASSWORD instead of upstream's hardcoded
// user@automatisch.io / sample. Idempotent: createUser() inserts only when the users table is empty.
import { createUser } from './utils.js';

const email = process.env.ADMIN_EMAIL;
const password = process.env.ADMIN_PASSWORD;

if (!email || !password) {
  console.error('ADMIN_EMAIL and ADMIN_PASSWORD must be set');
  process.exit(1);
}

createUser(email, password);
