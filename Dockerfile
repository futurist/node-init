FROM node

LABEL name="node-init" \
version="1.0" \
description="install dumb-init and cnpm globally"

# node have DNS problem, only loopback...
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org && npm cache clean
# ENV CNPM_ALIAS="npm --registry=https://registry.npm.taobao.org \
# --cache=$HOME/.npm/.cache/cnpm \
# --disturl=https://npm.taobao.org/mirrors/node \
# --userconfig=$HOME/.cnpmrc"

# Https://nodesource.com/blog/8-protips-to-start-killing-it-when-dockerizing-node-js/
COPY dumb-init_1.2.0_amd64.deb /tmp
RUN dpkg -i /tmp/dumb-init_*.deb && rm -f /tmp/*.deb

# Runs "/usr/bin/dumb-init -- /my/script --with --args"
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["bash"]
