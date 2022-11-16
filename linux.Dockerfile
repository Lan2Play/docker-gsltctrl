# escape=`

FROM debian:stable-slim AS builder
WORKDIR /dl

RUN apt-get update && apt-get install wget jq -y
RUN wget -O gsltctrl $(wget -qO- https://api.github.com/repos/991jo/gsltctrl-rs/releases/latest |jq -r ' .assets[] | select(.name | contains("gsltctrl-x86_64-unknown-linux-gnu")) | .browser_download_url')



FROM debian:stable-slim
HEALTHCHECK NONE
ARG BUILDNODE=unspecified
ARG SOURCE_COMMIT=unspecified
ENV GSLTCTRL_TOKEN=unspecified

LABEL com.lacledeslan.build-node=$BUILDNODE `
      org.label-schema.schema-version="1.0" `
      org.label-schema.url="https://lan2play.de" `
      org.label-schema.vcs-ref=$SOURCE_COMMIT `
      org.label-schema.vendor="lan2play" `
      org.label-schema.description="docker image of https://github.com/991jo/GSLTCTRL-RS" `
      org.label-schema.vcs-url="https://github.com/Lan2Play/docker-gsltctrl"


RUN useradd --user-group --system --create-home --no-log-init gsltctrl

COPY --chown=gsltctrl:gsltctrl --from=builder /dl/gsltctrl /app/GSLTCTRL-RS/gsltctrl

RUN chmod +x /app/GSLTCTRL-RS/gsltctrl;


USER gsltctrl
WORKDIR /app/GSLTCTRL-RS/

ENTRYPOINT [ "/app/GSLTCTRL-RS/gsltctrl" ]
