include scripts/Makefile.variable

# helm install \
# 	--set 'hydra.config.secrets.system={'$(LC_ALL=C tr -dc 'A-Za-z0-9' < /dev/urandom | base64 | head -c 32)'}' \
# 	--set 'hydra.config.dsn=memory' \
# 	--set 'hydra.config.urls.self.issuer=${hydra-issuer}' \
# 	--set 'hydra.config.urls.login=${hydra-login}' \
# 	--set 'hydra.config.urls.consent=${hydra-consent}' \
# 	ory/hydra

###########################################
# Fast run
###########################################
k8s-kind-fast: k8s-kind-cluster-delete k8s-kind-cluster-create k8s-kind-load-image k8s-helm-install k8s-hydra-reg-client

###########################################
# ORY-Hydra
###########################################
k8s-hydra-reg-client:
	# Wait for Ory-Hydra is ready
	kubectl wait pods \
		--namespace ${KUBE_MICROSERVICES_NAMESPACE} \
		--for condition=Ready \
		--selector=app.kubernetes.io/name=hydra \
		--timeout=90s

	kubectl exec \
	-n ${KUBE_MICROSERVICES_NAMESPACE} \
	-it $(shell kubectl get pod -l app.kubernetes.io/instance=chart-hydra1 -n ${KUBE_MICROSERVICES_NAMESPACE} -o jsonpath="{.items[0].metadata.name}") -- /bin/sh -c "\
   	hydra clients create \
	--endpoint ${hydra-endpoint-admin} \
	--id ${hydra-client-id} \
	--secret ${hydra-secret} \
	--grant-types authorization_code,refresh_token \
	--response-types code,id_token \
	--scope openid,offline \
	--callbacks ${hydra-callbacks} \
	--backchannel-logout-callback ${hydra-backchannel-logout-callback} \
	--backchannel-logout-session-required true \
	--frontchannel-logout-callback ${hydra-frontchannel-logout-callback} \
	--frontchannel-logout-session-required true \
	"

###########################################
# Helm
###########################################
k8s-helm-install: k8s-helm-install-loadbalancer

k8s-helm-install-loadbalancer:
	## Substitute environment variables
	$(MAKE) k8s-helm-secrets-envsubst
	
	## Ory-Hydra prepare config.
	$(MAKE) k8s-hydra-generate-config

	## Ingress
	helm install ${helm-ingress-nginx-chart-name} ${helm-chart-ingress-nginx}

	## Wait ingress-nginx
	kubectl wait \
		--namespace ingress-nginx \
		--for=condition=ready pod \
		--selector=app.kubernetes.io/component=controller \
		--timeout=90s

	## Create namespace
	kubectl create ns ${KUBE_MICROSERVICES_NAMESPACE}

	## Ory-Hydra database
	helm install \
		--namespace ${KUBE_MICROSERVICES_NAMESPACE} \
		${helm-hydra-database-chart-name} \
		${helm-chart-hydra-db-postgresql-dir} \
	 	--set persistence.existingClaim=${HYDRA_DB_POSTGRESQL_SERVICE_NAME}-pv-claim \
		--set volumePermissions.enabled=true \
		-f ${helm-chart-hydra-db-postgresql-dir}/.secret-values/values.yaml

	## Ory-Hydra service
	helm install \
		--namespace ${KUBE_MICROSERVICES_NAMESPACE} \
		${helm-hydra-chart-name} \
		${helm-chart-hydra-dir} \
		-f ${helm-chart-hydra-dir}/.secret-values/value-secrets.yaml \
		-f ${helm-chart-hydra-dir}/hydra-config.yaml

	## service-account database
	helm install \
		--namespace ${KUBE_MICROSERVICES_NAMESPACE} \
		${helm-service-account-database-chart-name} \
		${helm-chart-service-account-db-postgresql-dir} \
	 	--set persistence.existingClaim=service-account-postgresql-pv-claim \
		--set volumePermissions.enabled=true \
		-f ${helm-chart-service-account-db-postgresql-dir}/.secret-values/values.yaml

	## service-account
	helm install \
		--namespace ${KUBE_MICROSERVICES_NAMESPACE} \
		${helm-account-service-chart-name} \
		${helm-chart-service-account-dir} \
		-f ${helm-chart-service-account-dir}/.secret-values/secrets.yaml

k8s-helm-install-nodeport:
	## Substitute environment variables
	$(MAKE) k8s-helm-secrets-envsubst
	helm install ${helm-hydra-chart-name} ${helm-chart-service-account-dir}

k8s-helm-delete:
	## service-account
	helm uninstall \
		--namespace ${KUBE_MICROSERVICES_NAMESPACE} \
		${helm-account-service-chart-name}

	## service-account database
	helm uninstall \
		--namespace ${KUBE_MICROSERVICES_NAMESPACE} \
		${helm-service-account-database-chart-name}

	## Ory-Hydra service
	helm uninstall \
		--namespace ${KUBE_MICROSERVICES_NAMESPACE} \
		${helm-hydra-chart-name}
	
	## Ory-Hydra database
	helm uninstall \
		--namespace ${KUBE_MICROSERVICES_NAMESPACE} \
		${helm-hydra-database-chart-name}

	## Ingress
	helm uninstall ${helm-ingress-nginx-chart-name}

	## Delete namespace
	kubectl delete ns ingress-nginx
	kubectl delete ns ${KUBE_MICROSERVICES_NAMESPACE}
	
	## Load balancer
	#helm uninstall metallb

k8s-helm-show:
	helm show all ${helm-chart-service-account-dir}

k8s-helm-verify:
	helm verify	${helm-chart-service-account-dir}

k8s-helm-lint:
	helm lint ${helm-chart-service-account-dir}

k8s-helm-secrets-envsubst:
	## hydra db postgresql
	envsubst < ${helm-chart-hydra-db-postgresql-dir}/deploy-config/values.yaml > ${helm-chart-hydra-db-postgresql-dir}/.secret-values/values.yaml
	## hydra
	envsubst < ${helm-chart-hydra-dir}/deploy-config/value-secrets.yaml > ${helm-chart-hydra-dir}/.secret-values/value-secrets.yaml

	## service-account db postgresql
	envsubst < ${helm-chart-service-account-db-postgresql-dir}/deploy-config/values.yaml > ${helm-chart-service-account-db-postgresql-dir}/.secret-values/values.yaml
	## service-account
	envsubst < ${helm-chart-service-account-dir}/deploy-config/secrets.yaml > ${helm-chart-service-account-dir}/.secret-values/secrets.yaml
	envsubst < ${helm-chart-service-account-dir}/deploy-config/configmap.yaml > ${helm-chart-service-account-dir}/templates/configmap.yaml

###########################################
# k8s common
###########################################
k8s-build:
	## Build hydra image
	docker build -t ${docker-full-image-hydra-name} -f "${docker-image-hydra-path}" "${hydra-dir}"

	## Build service-account image
	docker build -t ${docker-full-image-sa-name} -f "${docker-image-sa-path}" "${service-account-dir}"

# k8s-run:
# 	## Run via CMD
# 	# kubectl run ${docker-image-hydra-name} --image=${docker-full-image-hydra-name} --image-pull-policy=Never
# 	## Run via config.
# 	kubectl apply ${kube-deploy-command}

# k8s-stop:
# 	# kubectl delete pod ${docker-image-hydra-name}
# 	kubectl delete ${kube-deploy-command}

# k8s-describe:
# 	kubectl describe ${kube-deploy-command}

k8s-hydra-generate-config:
	## Ory-Hydra prepare config.
	@echo "hydra:\n \
  config:" > ${helm-chart-hydra-dir}/hydra-config.yaml && sed 's/^/    /' ./config/hydra/dev/hydra.yml >> ${helm-chart-hydra-dir}/hydra-config.yaml

###########################################
# kind
###########################################
k8s-kind-cluster-create: k8s-kind-cluster-create-loadbalancer

k8s-kind-cluster-create-loadbalancer:
	### Need run by admin or there will be an error.
	# loadbalancer
	kind create cluster --name ${ms-cluster-name} --config ${kind-config-loadbalancer-path}

k8s-kind-cluster-create-nodeport:
	### Need run by admin or there will be an error.
	kind create cluster --name ${ms-cluster-name} --config ${kind-config-nodeport-path}

k8s-kind-cluster-delete:
	kind delete cluster --name ${ms-cluster-name}

k8s-kind-load-image:
	## Load docker images to kind
	kind load docker-image \
		${docker-full-image-hydra-name} \
		${docker-full-image-sa-name} \
		--name ${ms-cluster-name}

k8s-kind-build: k8s-build k8s-kind-load-image