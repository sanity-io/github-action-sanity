# GitHub Action for Sanity.io

This Action wraps the [Sanity CLI](https://github.com/sanity-io/sanity) to enable studio deployment from GitHub.

## Usage

```workflow
workflow "Deploy on sanity.studio" {
  on = "push"
  resolves = ["deploy"]
}

action "deploy" {
  needs = ["deploy"]
  uses = "docker://kmelve/github-actions-sanity-io"
  args = "deploy"
  secrets = [
    "SANITY_AUTH_TOKEN",
  ]
}
```

### Secrets

- `SANTY_AUTH_TOKEN` - **Required**. The token to use for authentication with the Sanity.io API ([more info](https://www.sanity.io/docs))

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).

Container images built with this project include third party materials. See [THIRD_PARTY_NOTICE.md](THIRD_PARTY_NOTICE.md) for details.
