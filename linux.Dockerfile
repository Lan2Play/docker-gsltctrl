# escape=`

FROM rust:latest AS builder
WORKDIR /dl

RUN git clone https://github.com/991jo/GSLTCTRL-RS.git

RUN cd GSLTCTRL-RS && cargo build --release


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

COPY --chown=gsltctrl:gsltctrl --from=builder /dl/GSLTCTRL-RS/target/release/gsltctrl /app/GSLTCTRL-RS/gsltctrl

RUN chmod +x /app/GSLTCTRL-RS/gsltctrl;


USER gsltctrl
WORKDIR /app/GSLTCTRL-RS/

ENTRYPOINT [ "/app/GSLTCTRL-RS/gsltctrl" ]
