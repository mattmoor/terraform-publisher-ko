variable "base_image" {
  description = "The base image to build on top of."
  default     = "cgr.dev/chainguard/static:latest-glibc"
}

variable "base_image_policy" {
  description = "The policy to verify the base image with."
  default     = <<EOF
apiVersion: policy.sigstore.dev/v1beta1
kind: ClusterImagePolicy
metadata:
  name: base-policy
spec:
  images:
    - glob: "**"
  authorities:
    - keyless:
        url: https://fulcio.sigstore.dev
        identities:
          - issuer: https://token.actions.githubusercontent.com
            subject: https://github.com/chainguard-images/images/.github/workflows/release.yaml@refs/heads/main
      ctlog:
        url: https://rekor.sigstore.dev
EOF
}

variable "working_dir" {
  description = "The working directory to build from."
  type        = string
}

variable "importpath" {
  description = "The go import path to ko build."
  type        = string
}
