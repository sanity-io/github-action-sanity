# GitHub Action for Sanity.io

This Action wraps the [Sanity CLI](https://github.com/sanity-io/sanity) for usage inside workflows.

## Breaking change in `v0.3`

Prior to `v0.3`, all `args` would be appended to the `sanity` command in entrypoint.sh (meaning one or more `args` was required).

As of `v0.3`, entrypoint.sh requires at least two `args`. The first is used to specify the current directory (`.`) or a subdirectory (e.g., `studio`, as with a monorepo). All subsequent `args` are appended to the `sanity` command.

### Sample deployment snippet

Example snippet to run `sanity deploy`, where the studio is installed in a `studio` subdirectory (see below for full example):

```yaml
# deploy-sanity-studio.yml

# ... other workflow commands ...

with:
  args: studio deploy
```

This is _not_ running a command called `studio deploy`. Rather, it is running `cd studio` followed by `sanity deploy`.

---

### Sample backup snippet

Example snippet to run `sanity dataset export production backups/backup.tar.gz`, where the studio is installed at the root of the repository (see below for full example):

```yaml
# sanity-backup.yml

# ... other workflow commands ...

with:
  args: . dataset export production backups/backup.tar.gz
```

This will run `cd .` (remaining at the root of the repository) followed by `sanity dataset export production backups/backup.tar.gz`.

## Usage

Below are two examples of usage. Do you use this GitHub Action for a different purpose? Submit a pull request!

Depending on your use case, you will need to [generate a read or write token](https://www.sanity.io/docs/http-auth#4c21d7b829fe) from your project's management console and then [add it as a secret](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository) in the Studio GitHub repository. In the examples below, the secret was named `SANITY_AUTH_TOKEN`.

### Studio deployment on push requests

_This workflow requires a read token._

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
      - uses: sanity-io/github-action-sanity@v0.4
        env:
          SANITY_AUTH_TOKEN: ${{ secrets.SANITY_AUTH_TOKEN }}
        with:
          args: . deploy
```

If your studio is in a subdirectory, replace `.` in `args` with the name of your subdirectory (e.g., `args: studio deploy`)

### Backup routine

Thanks to [scheduled events](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#schedule) and [artifacts](https://docs.github.com/en/actions/advanced-guides/storing-workflow-data-as-artifacts), you can set up a simple backup routine.

Backup files will appear as downloadable artifacts in the workflow summary. Keep in mind that artifacts are automatically deleted [after a certain period of time](https://docs.github.com/en/actions/learn-github-actions/usage-limits-billing-and-administration#artifact-and-log-retention-policy) (after 90 days by default for public repositories).

_This workflow requires a read token._

```yaml
name: Backup Routine
on:
  schedule:
    # Runs at 04:00 UTC on the 1st and 17th of every month
    - cron: "0 4 */16 * *"
jobs:
  backup-dataset:
    runs-on: ubuntu-18.04
    name: Backup dataset
    steps:
      - uses: actions/checkout@v2
      - name: Export dataset
        uses: sanity-io/github-action-sanity@v0.4
        env:
          SANITY_AUTH_TOKEN: ${{ secrets.SANITY_AUTH_TOKEN }}
        with:
          args: . dataset export production backups/backup.tar.gz
      - name: Upload backup.tar.gz
        uses: actions/upload-artifact@v2
        with:
          name: backup-tarball
          path: backups/backup.tar.gz
          # Fails the workflow if no files are found; defaults to 'warn'
          if-no-files-found: error
```

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).

Container images built with this project include third-party materials. See [THIRD_PARTY_NOTICE.md](THIRD_PARTY_NOTICE.md) for details.
