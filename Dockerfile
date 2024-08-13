FROM node:20

LABEL version="1.1.0"
LABEL repository="http://github.com/sanity-io/actions-sanity-io"
LABEL homepage="http://github.com/actions/actions-sanity-io"
LABEL maintainer="Sanity.io <hello@sanity.io>"

LABEL "com.github.actions.name"="GitHub Action for Sanity.io"
LABEL "com.github.actions.description"="Wraps the Sanity CLI to enable common commands."
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="red"
COPY LICENSE README.md THIRD_PARTY_NOTICE.md /

RUN yarn global add @sanity/cli

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
