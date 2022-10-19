# escape=`

FROM bitnami/git:latest AS builder
WORKDIR /dl

RUN git clone https://github.com/991jo/gsltctrl_minimal.git


FROM python:slim
HEALTHCHECK NONE
ARG BUILDNODE=unspecified
ARG SOURCE_COMMIT=unspecified
ENV APIKEY=unspecified

LABEL com.lacledeslan.build-node=$BUILDNODE `
      org.label-schema.schema-version="1.0" `
      org.label-schema.url="https://lan2play.de" `
      org.label-schema.vcs-ref=$SOURCE_COMMIT `
      org.label-schema.vendor="lan2play" `
      org.label-schema.description="docker image of https://github.com/991jo/gsltctrl_minimal" `
      org.label-schema.vcs-url="https://github.com/Lan2Play/docker-gsltctrl"


RUN useradd --user-group --system --create-home --no-log-init gsltctrl

COPY --chown=gsltctrl:gsltctrl --from=builder /dl/gsltctrl_minimal /app/gsltctrl_minimal
COPY --chown=gsltctrl:gsltctrl /dist/gsltctrl_minimal/runscript.sh /app/gsltctrl_minimal/runscript.sh

RUN chmod +x /app/gsltctrl_minimal/runscript.sh;


USER gsltctrl
WORKDIR /app/gsltctrl_minimal/

ENTRYPOINT [ "/app/gsltctrl_minimal/runscript.sh" ]
