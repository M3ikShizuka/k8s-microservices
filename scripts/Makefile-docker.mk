command := docker-compose -p microservice1 -f deployments/docker/docker-compose.yml -f service-account/deployments/docker/service.yml -f service-account/deployments/docker/postgresql.yml -f deployments/docker/hydra.yml -f deployments/docker/hydra-postgres.yml
# add -f deployments/docker/consent.yml for start default hydra consent app.

host-account-service := 127.0.0.1
host-hydra := 127.0.0.1
callbacks := http://${host-account-service}:3000/callback
backchannel-logout-callback := http://${host-account-service}:3000/backchannel-logout
frontchannel-logout-callback := http://${host-account-service}:3000/frontchannel-logout
endpoint-admin := http://${host-hydra}:4445
client-id := client-auth-code-service-account
secret := client-secret-service-account

conf:
	${command} config

build:
	${command} build

build-debug:
	$(eval command = ${command} -f hydra/quickstart-debug.yml -f deployments/docker/hydra-debug.yml)
	${command} build

start:
	${command} up -d

register-app:
	${command} exec hydra hydra clients create --endpoint ${endpoint-admin} --id ${client-id} --secret ${secret} --grant-types authorization_code,refresh_token --response-types code,id_token --scope openid,offline --callbacks ${callbacks} --backchannel-logout-callback ${backchannel-logout-callback} --backchannel-logout-session-required true --frontchannel-logout-callback ${frontchannel-logout-callback} --frontchannel-logout-session-required true

install: start register-app

install-debug: build-debug register-app

stop:
	${command} stop

down:
	${command} down

clean: down
	
test.integration: build start
	# Integration test