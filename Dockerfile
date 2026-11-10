# Automatisch for Railway.
#
# Upstream seeds a hardcoded login (user@automatisch.io / sample) on first boot, which on a public
# URL is an open door. This wrapper seeds the admin from ADMIN_EMAIL / ADMIN_PASSWORD instead (the
# password is a Railway secret), and makes ioredis resolve Railway's IPv6-only private DNS names.
# Web and worker run from this one image; WORKER=true selects the worker.
FROM automatischio/automatisch:0.15.0@sha256:3bace7a12d5fb3f5b1305a6a52232270e0e0abd8465a8b78baacb07f6ea89594

ENV APP_ENV=production \
    POSTGRES_DATABASE=automatisch \
    POSTGRES_USERNAME=postgres \
    TELEMETRY_ENABLED=false \
    ADMIN_EMAIL=admin@example.com

# ioredis defaults to IPv4-only lookups (family: 4); redis.railway.internal is AAAA-only.
RUN sed -i "s/  enableReadyCheck: true,/  enableReadyCheck: true,\n  family: 0,/" /automatisch/packages/backend/src/config/redis.js \
 && grep -q "family: 0" /automatisch/packages/backend/src/config/redis.js

COPY seed-admin.js /automatisch/packages/backend/bin/database/seed-admin.js
COPY railway-entrypoint.sh /railway-entrypoint.sh
RUN chmod +x /railway-entrypoint.sh

ENTRYPOINT ["/railway-entrypoint.sh"]
