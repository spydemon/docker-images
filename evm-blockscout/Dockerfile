# This Dockerfile is inspired from:
# https://github.com/blockscout/blockscout/blob/master/docker/Dockerfile

FROM bitwalker/alpine-elixir-phoenix:1.12.2
LABEL maintainer="jsaipakoimetr@spyzone.fr"

RUN apk --no-cache --update add git
RUN rm -rf '/opt/app'

# Get blockscout sources
RUN git clone 'https://github.com/blockscout/blockscout.git' '/opt/app'

RUN apk --no-cache --update add alpine-sdk gmp-dev automake libtool inotify-tools autoconf python3 file

# Get Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="$HOME/.cargo/bin:${PATH}"
ENV RUSTFLAGS="-C target-feature=-crt-static"

EXPOSE 4000

ENV PORT=4000 \
    MIX_ENV="prod" \
    SECRET_KEY_BASE="RMgI4C1HSkxsEjdhtGMfwAHfyT6CKWXOgzCboJflfSm4jeAlic52io05KB6mqzc5"

RUN mix do deps.get, local.rebar --force, deps.compile

#ARG COIN
RUN if [ "$COIN" != "" ]; then sed -i s/"POA"/"${COIN}"/g apps/block_scout_web/priv/gettext/en/LC_MESSAGES/default.po; fi

# Run forderground build and phoenix digest
RUN mix compile

RUN npm install npm@latest

# Add blockscout npm deps
RUN cd apps/block_scout_web/assets/ && \
    npm install && \
    npm run deploy && \
    cd -

RUN cd apps/explorer/ && \
    npm install && \
    apk update && apk del --force-broken-world alpine-sdk gmp-dev automake libtool inotify-tools autoconf python3

RUN mix phx.digest

RUN echo '/bin/sh -c "mix do ecto.create, ecto.migrate; mix phx.server"' > /opt/app/startup.sh;
RUN chmod a+x /opt/app/startup.sh;

ENTRYPOINT ./startup.sh