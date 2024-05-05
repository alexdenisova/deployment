# deployment

Deployment of my projects into Kubernetes with the help of Helm charts.

## Projects

### Pantry Tracker

Backend: <https://github.com/alexdenisova/pantry-tracker-backend>

Frontend: <https://github.com/alexdenisova/pantry-tracker-frontend>

## Repo Structure

- [`.github`](.github/) - pipeline directory
- [`helm-charts`](helm-charts/) - Helm chart directory
- [`values`](values/) - directory with values for Helm charts
  - `*.env` - pipeline environment variables
  - `*.values.yaml` - values for Helm chart
  - `*.sops.yaml` - secrets for Helm chart
