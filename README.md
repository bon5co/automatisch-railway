# automatisch-railway

Thin wrapper over `automatischio/automatisch` for the Railway template "Automatisch". Seeds the first admin from
`ADMIN_EMAIL` / `ADMIN_PASSWORD` instead of upstream's hardcoded login, and lets ioredis reach Railway's IPv6 private DNS.
Web and worker run from this one image (`WORKER=true` selects the worker).
