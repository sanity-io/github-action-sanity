FROM node:18

LABEL version="1.1.0"
LABEL repository="http://github.com/sanity-io/actions-sanity-io"
LABEL homepage="http://github.com/actions/actions-sanity-io"
LABEL maintainer="Sanity.io <hello@sanity.io>"

LABEL "com.github.actions.name"="GitHub Action for Sanity Composable Content Cloud"
LABEL "com.github.actions.description"="Wraps the Sanity CLI to enable common commands."
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="red"
COPY LICENSE README.md THIRD_PARTY_NOTICE.md /

RUN yarn global add sanity

ARG NPM_SCOPE
ARG NPM_TOKEN
ARG REGISTRY_DOMAIN

RUN if [[ -z "$NPM_SCOPE" && -z "$NPM_TOKEN" && -z "$REGISTRY_DOMAIN" ]]; \
    then \
    echo -e "//$REGISTRY_DOMAIN/:_authToken=$NPM_TOKEN\\n$NPM_SCOPE:registry=https://$REGISTRY_DOMAIN/" > .npmrc ; \
    fi

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
