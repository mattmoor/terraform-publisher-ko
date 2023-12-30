# Build a simple "hello world" image

This example builds a very simple "hello world" image.

It can be deployed by running the following commands:

```
export TF_VAR_target_repository=ghcr.io/${USER}
terraform init
terraform apply -auto-approve
```