# GitHub Action for Sanity.io

This Action wraps the [Sanity CLI](https://github.com/sanity-io/sanity) to enable studio deployment from GitHub.

## Usage

```yaml
name: Deploy Sanity
on:
  push:
    branches: [main]
jobs:
  sanity-deploy:
    runs-on: ubuntu-latest
    name: Deploy Sanity
    steps:
      - uses: actions/checkout@v2
      - uses: sanity-io/github-action-sanity@v0.1-alpha
        env:
          SANITY_AUTH_TOKEN: ${{ secrets.SANITY_AUTH_TOKEN }}
        with:
          args: deploy
```

### Secrets

- `SANITY_AUTH_TOKEN` - **Required**. The token to use for authentication with the Sanity.io API ([more info](https://www.sanity.io/docs))

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).

Container images built with this project include third party materials. See [THIRD_PARTY_NOTICE.md](THIRD_PARTY_NOTICE.md) for details.
