ARG SCANSERVJS_VERSION=3.2.0

FROM sbs20/scanservjs:${SCANSERVJS_VERSION}

# Brother's brscan4 network scanner driver. Needed because sane-airscan's
# WSD backend for this printer only advertises 100/200/300dpi, while
# brscan4 exposes the printer's full resolution range.
ARG BRSCAN4_VERSION=0.4.11-1
ARG BRSCAN4_URL=https://download.brother.com/welcome/dlf105200/brscan4-${BRSCAN4_VERSION}.amd64.deb

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates \
    && curl -fsSL -o /tmp/brscan4.deb "${BRSCAN4_URL}" \
    && dpkg -i --force-all /tmp/brscan4.deb \
    && rm -f /tmp/brscan4.deb \
    && apt-get purge -y curl \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /brscan-entrypoint.sh
RUN chmod +x /brscan-entrypoint.sh

ENTRYPOINT ["/brscan-entrypoint.sh"]
