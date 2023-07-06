all: clean setup
	docker-compose config -q && docker-compose up --build --force-recreate --remove-orphans -d
	docker ps -a
	sleep 1
	$(CURDIR)/tests/curl/alarm.sh

setup: check-env
	sed \
		-e "s,APP_URL,host.docker.internal:8080,g" \
		$(CURDIR)/templates/prometheus.yml > $(CURDIR)/.generated/prometheus.yml
	sed \
		-e "s,SLACK_CHANNEL,$(SLACK_CHANNEL),g" \
		-e "s,SLACK_URL,$(SLACK_URL),g" \
		templates/alertmanager.yml > $(CURDIR)/.generated/alertmanager.yml

check-env:
	if test "$(SLACK_URL)" = "" ; then \
		echo "Error: SLACK_URL env var not set"; \
			exit 1; \
	fi
	if test "$(SLACK_CHANNEL)" = "" ; then \
		echo "Error: SLACK_CHANNEL env var not set"; \
			exit 1; \
	fi

clean:
	docker-compose down --remove-orphans -v
