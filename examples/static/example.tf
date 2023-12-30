terraform {
  required_providers {
    cosign = { source = "chainguard-dev/cosign" }
    ko     = { source = "ko-build/ko" }
  }
}

variable "target_repository" {
  description = "The docker repo into which the image and attestations should be published."
}

provider "ko" {
  docker_repo = var.target_repository
}

module "image" {
  source      = "../.."
  working_dir = path.module
  importpath  = "."
}

data "cosign_verify" "image-signatures" {
  image    = module.image.image_ref

  policy = jsonencode({
    apiVersion = "policy.sigstore.dev/v1beta1"
    kind       = "ClusterImagePolicy"
    metadata = {
      name = "signed"
    }
    spec = {
      images = [{ glob = "**" }]
      authorities = [{
        keyless = {
          url = "https://fulcio.sigstore.dev"
          identities = [{
            issuer  = "https://token.actions.githubusercontent.com"
            subject = "https://github.com/mattmoor/terraform-publisher-ko/.github/workflows/test.yaml@refs/heads/main"
          }]
        }
        ctlog = {
          url = "https://rekor.sigstore.dev"
        }
      }]
    }
  })
}

output "image_ref" {
  value = module.image.image_ref
}
