terraform {
  required_providers {
    ko     = { source = "ko-build/ko" }
    cosign = { source = "chainguard-dev/cosign" }
    oci    = { source = "chainguard-dev/oci" }
  }
}

data "cosign_verify" "base" {
  image  = var.base_image
  policy = var.base_image_policy
}

resource "ko_build" "this" {
  base_image  = data.cosign_verify.base.verified_ref
  working_dir = var.working_dir
  importpath  = var.importpath
}

resource "cosign_sign" "signature" {
  image = ko_build.this.image_ref

  # Only keep the latest signature. We use these to ensure we regularly rebuild.
  conflict = "REPLACE"
}

# TODO(mattmoor): attest the SBOM
