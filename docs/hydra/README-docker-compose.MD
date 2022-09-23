# Docker compose
**Build Dev version**
### Check config
```bash
docker-compose -p microservice1 -f deployments/docker/docker-compose.yml -f service-account/deployments/service.yml -f service-account/deployments/postgresql.yml -f deployments/docker/hydra.yml -f deployments/docker/hydra-postgres.yml -f hydra/quickstart-debug.yml config
```

** Debug config **
```bash
docker-compose -p microservice1 -f deployments/docker/docker-compose.yml -f service-account/deployments/service.yml -f service-account/deployments/postgresql.yml -f deployments/docker/hydra.yml -f deployments/docker/hydra-postgres.yml -f hydra/quickstart-debug.yml -f deployments/docker/hydra-debug.yml config
```

### Start
```bash
docker-compose -p microservice1 -f deployments/docker/docker-compose.yml -f service-account/deployments/service.yml -f service-account/deployments/postgresql.yml -f deployments/docker/hydra.yml -f deployments/docker/hydra-postgres.yml -f hydra/quickstart-debug.yml up --build -d
```

### Stop
```bash
docker-compose -p microservice1 -f deployments/docker/docker-compose.yml -f service-account/deployments/service.yml -f service-account/deployments/postgresql.yml -f deployments/docker/hydra.yml -f deployments/docker/hydra-postgres.yml stop
```

### Remove
```bash
docker-compose -p microservice1 -f deployments/docker/docker-compose.yml -f service-account/deployments/service.yml -f service-account/deployments/postgresql.yml -f deployments/docker/hydra.yml -f deployments/docker/hydra-postgres.yml down
```

## Hydra
### Сreate the OAuth 2.0 Client with grant-types client credentials:
```bash
docker-compose -p microservice1 -f deployments/docker/docker-compose.yml -f service-account/deployments/service.yml -f service-account/deployments/postgresql.yml -f deployments/docker/hydra.yml -f deployments/docker/hydra-postgres.yml exec hydra hydra clients create --endpoint http://127.0.0.1:4445/ --id my-client --secret client-secret-service-account --grant-types client_credentials
```

### Perform the client credentials grant:
```bash
docker-compose -p microservice1 -f deployments/docker/docker-compose.yml -f service-account/deployments/service.yml -f service-account/deployments/postgresql.yml -f deployments/docker/hydra.yml -f deployments/docker/hydra-postgres.yml exec hydra hydra token client --endpoint http://127.0.0.1:4444/ --client-id my-client --client-secret client-secret-service-account
```

Output: $token$
### Perform token introspection on received token (it checks that access token is valid token and not the dummy value):
```bash
docker-compose -p microservice1 -f deployments/docker/docker-compose.yml -f service-account/deployments/service.yml -f service-account/deployments/postgresql.yml -f deployments/docker/hydra.yml -f deployments/docker/hydra-postgres.yml exec hydra hydra token introspect --endpoint http://127.0.0.1:4445/ $token$
```

Output data sample:
```json
{
    "active": true,
    "aud": [],
    "client_id": "my-client",
    "exp": 1658328094,
    "iat": 1658324494,
    "iss": "http://127.0.0.1:4444/",
    "nbf": 1658324494,
    "sub": "my-client",
    "token_type": "Bearer",
    "token_use": "access_token"
}
```

### Perform the OAuth 2.0 Authorization Code Grant. It usually makes client front-end app:
Note: that you need to add --token-endpoint-auth-method none if your clients are public (such as SPA apps and native apps) because the public clients can't provide client secrets.

**Without refresh token:**
```bash
docker-compose -p microservice1 -f deployments/docker/docker-compose.yml -f service-account/deployments/service.yml -f service-account/deployments/postgresql.yml -f deployments/docker/hydra.yml -f deployments/docker/hydra-postgres.yml exec hydra hydra clients create --endpoint http://127.0.0.1:4445 --id client-auth-code-service-account --secret client-secret-service-account --grant-types authorization_code --response-types code,id_token --scope openid,offline --callbacks http://127.0.0.1:5555/callback

--backchannel-logout-callback http://127.0.0.1:3000/backchannel-logout
--backchannel-logout-session-required true
--frontchannel-logout-callback http://127.0.0.1:3000/frontchannel-logout
--frontchannel-logout-session-required true
```

**With refresh token:**
```bash
docker-compose -p microservice1 -f deployments/docker/docker-compose.yml -f service-account/deployments/service.yml -f service-account/deployments/postgresql.yml -f deployments/docker/hydra.yml -f deployments/docker/hydra-postgres.yml exec hydra hydra clients create --endpoint http://127.0.0.1:4445 --id client-auth-code-service-account --secret client-secret-service-account --grant-types authorization_code,refresh_token --response-types code,id_token --scope openid,offline --callbacks http://127.0.0.1:5555/callback

--backchannel-logout-callback http://127.0.0.1:3000/backchannel-logout
--backchannel-logout-session-required true
--frontchannel-logout-callback http://127.0.0.1:3000/frontchannel-logout
--frontchannel-logout-session-required true
```

### Client Front example:
The following command starts a server that serves an example web application. The application will perform the OAuth 2.0 Authorization Code Flow using Ory Hydra. The web server runs on http://127.0.0.1:5555.
```bash
docker-compose -p microservice1 -f deployments/docker/docker-compose.yml -f service-account/deployments/service.yml -f service-account/deployments/postgresql.yml -f deployments/docker/hydra.yml -f deployments/docker/hydra-postgres.yml exec hydra hydra token user --client-id client-auth-code-service-account --client-secret client-secret-service-account --endpoint http://127.0.0.1:4444/ --port 5555 --scope openid,offline --no-shutdown true
```

**Run with dlv go debugger for remote debug**
```bash
docker-compose -p microservice1 -f deployments/docker/docker-compose.yml -f service-account/deployments/service.yml -f service-account/deployments/postgresql.yml -f deployments/docker/hydra.yml -f deployments/docker/hydra-postgres.yml -f hydra/quickstart-debug.yml exec hydra /dlv --listen=:40001 --headless=true --api-version=2 exec /usr/bin/hydra -- token user --client-id client-auth-code-service-account --client-secret client-secret-service-account --endpoint http://127.0.0.1:4444/ --port 5555 --scope openid,offline --no-shutdown true
```