# Setup Aircloak Insights on Kubernetes

The provided setup is geared at proof of concept installations,
rather than productive ones. In a productive environment you will
want to use a properly managed Postgres instance as a data store
for Aircloak insights, and you might want multiple Insight Cloak
instances as well.

Perform the following steps to create a test installation:

- have `kubectl` set to reference the Kubernetes cluster you want to deploy to
- update the `00-aircloak-external-pull-secret.yaml` file to include your
  Aircloak provided pull-secrets
- run the `setup-and-deploy.sh namespace` script to deploy an instance
  of Aircloak Insights.
