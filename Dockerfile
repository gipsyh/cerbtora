FROM ubuntu:latest AS builder
RUN apt-get update && apt-get install -y \
      bash coreutils build-essential cmake \
      meson pkg-config m4 libgmp-dev libmpfr-dev \
      git ca-certificates

WORKDIR /work
COPY . .
RUN rm -rf build bin
RUN make

FROM ubuntu:latest
RUN apt-get update && apt-get install -y bash libmpfr6 libgmp10
COPY --from=builder /work/bin/* /usr/local/bin
ENTRYPOINT ["check"]
