ARG FROM_IMAGE=baserow/baserow:1.35.0

FROM $FROM_IMAGE AS image_base
RUN apt-get remove -y "postgresql-$POSTGRES_VERSION" redis-server

ENV DATA_DIR=/baserow/data

RUN mkdir -p "$DATA_DIR" && \
    chown -R 9999:9999 "$DATA_DIR"

COPY deploy/heroku/heroku_env.sh /baserow/supervisor/env/heroku_env.sh

# Make heroku_env.sh executable (if it needs to be executed)
RUN chmod +x /baserow/supervisor/env/heroku_env.sh

# Add the actual start command, adjust path and command as needed.
# Example: starting Baserow with supervisord or another command.
CMD ["supervisord", "-c", "/baserow/supervisor/supervisord.conf"]
