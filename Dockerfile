FROM alpine:latest

# Install required dependencies
RUN apk add --no-cache bash tini wget

# Set the ttyd version (check latest from releases page)
ARG TTYD_VERSION=1.7.7
ARG TARGETARCH

# Fix architecture names for GitHub Releases
RUN ARCH=$([ "$TARGETARCH" = "amd64" ] && echo "x86_64" || echo "$TARGETARCH") && \
    wget -qO /usr/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/${TTYD_VERSION}/ttyd.${ARCH} && \
    chmod +x /usr/bin/ttyd

# Expose port for ttyd
EXPOSE 7681
WORKDIR /root

# Start ttyd
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["ttyd", "-W", "bash"]
