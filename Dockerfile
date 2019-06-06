FROM ruby:2.4-slim
LABEL maintainer="Boye Holden <esselt@esselt.net>"

# Define environment variables, these are not changeable
ENV RAILS_ROOT /usr/src/app
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true

# Update and download needed packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        default-libmysqlclient-dev \
        nodejs \
        wget \
    && rm -rf /var/lib/apt/lists/*

# Install freetds, used for accessing SQL Server
RUN wget ftp://ftp.freetds.org/pub/freetds/stable/freetds-1.1.6.tar.gz \
    && tar -xzf freetds-1.1.6.tar.gz \
    && cd freetds-1.1.6 \
    && ./configure --prefix=/usr/local --with-tdsver=7.3 \
    && make \
    && make install \
    && cd .. \
    && rm -rf freetds-1.1.6*

# Add user and run everything as this user
RUN groupadd -g 1000 -r app \
    && useradd -g app -u 1000 -d $RAILS_ROOT -m -r app
USER app

# Create and use path for rails root
WORKDIR $RAILS_ROOT

# Start with installing gems
COPY --chown=app:app Gemfile Gemfile.lock ./
RUN bundle install --without development test -j4 --retry 3 \
    && rm -rf /usr/local/bundle/cache/*.gem \
    && find /usr/local/bundle/gems/ -name "*.c" -delete \
    && find /usr/local/bundle/gems/ -name "*.o" -delete

# The entire app
COPY --chown=app:app . ./

# Port used
EXPOSE 3000

# Start script
CMD ["sh", "entrypoint.sh"]