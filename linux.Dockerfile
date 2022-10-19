# escape=`

FROM debian:11 AS builder
WORKDIR /dl

RUN apt-get update && apt-get install -y git curl gnupg2
RUN git clone https://github.com/991jo/gsltctrl_minimal.git


FROM debian:11
HEALTHCHECK NONE
ARG BUILDNODE=unspecified
ARG SOURCE_COMMIT=unspecified

LABEL com.lacledeslan.build-node=$BUILDNODE `
      org.label-schema.schema-version="1.0" `
      org.label-schema.url="https://lan2play.de" `
      org.label-schema.vcs-ref=$SOURCE_COMMIT `
      org.label-schema.vendor="lan2play" `
      org.label-schema.description="docker image of https://github.com/991jo/gsltctrl_minimal" `
      org.label-schema.vcs-url="https://github.com/Lan2Play/docker-gsltctrl"


RUN apt-get update && apt-get install -y `
    python3 &&`
    apt-get clean &&`
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*;

RUN useradd --user-group --system --create-home --no-log-init gsltctrl

COPY --chown=gsltctrl:gsltctrl --from=builder /dl/gsltctrl_minimal /app/gsltctrl_minimal
COPY --chown=gsltctrl:gsltctrl /dist/gsltctrl_minimal/runscript.sh /app/gsltctrl_minimal/runscript.sh

RUN chmod +x /app/gsltctrl_minimal/runscript.sh;


USER gsltctrl
WORKDIR /app/gsltctrl_minimal/

ENTRYPOINT [ "/app/gsltctrl_minimal/runscript.sh" ]
