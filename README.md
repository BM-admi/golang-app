# golang-app

## Sample golang app with monitoring stack:
- [App](http://localhost:8080)
- [Grafana](http://localhost:3000)
- [Prometheus](http://localhost:9090)
- [AleretManager](http://localhost:9093)
- Slack alerting with Prometheus alerting rules

## Testing
```
SLACK_URL=https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX SLACK_CHANNEL=foo make
```
