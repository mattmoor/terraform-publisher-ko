# Build ko images with terraform.

This repository contains a terraform module to facilitate building an image with
ko using a verified base image and signing the supply chain metadata with
ambient credentials (e.g. github actions workload identity).

Currently the following supply chain metadata is surfaced:
1. The images are signed by the workload,

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cosign"></a> [cosign](#provider\_cosign) | n/a |
| <a name="provider_ko"></a> [ko](#provider\_ko) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cosign_sign.signature](https://registry.terraform.io/providers/chainguard-dev/cosign/latest/docs/resources/sign) | resource |
| [ko_build.this](https://registry.terraform.io/providers/ko-build/ko/latest/docs/resources/build) | resource |
| [cosign_verify.base](https://registry.terraform.io/providers/chainguard-dev/cosign/latest/docs/data-sources/verify) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_base_image"></a> [base\_image](#input\_base\_image) | The base image to build on top of. | `string` | `"cgr.dev/chainguard/static:latest-glibc"` | no |
| <a name="input_base_image_policy"></a> [base\_image\_policy](#input\_base\_image\_policy) | The policy to verify the base image with. | `string` | `"apiVersion: policy.sigstore.dev/v1beta1\nkind: ClusterImagePolicy\nmetadata:\n  name: base-policy\nspec:\n  images:\n    - glob: \"**\"\n  authorities:\n    - keyless:\n        url: https://fulcio.sigstore.devn        identities:\n          - issuer: https://token.actions.githubusercontent.comn            subject: https://github.com/chainguard-images/images/.github/workflows/release.yaml@refs/heads/mainn      ctlog:\n        url: https://rekor.sigstore.devn"` | no |
| <a name="input_importpath"></a> [importpath](#input\_importpath) | The go import path to ko build. | `string` | n/a | yes |
| <a name="input_working_dir"></a> [working\_dir](#input\_working\_dir) | The working directory to build from. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_image_ref"></a> [image\_ref](#output\_image\_ref) | n/a |
<!-- END_TF_DOCS -->
