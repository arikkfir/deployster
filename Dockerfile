FROM python:3.6.5-alpine3.7 AS build
ARG CODECOV_TOKEN=""
ENV PYTHONIOENCODING="utf-8"
ENV PYTHONPATH="/app/src:/app/resources/src"
ENV PYTHONUNBUFFERED="1"

RUN apk --no-cache --update add bash

WORKDIR /app/
COPY ./requirements.txt /app/
RUN pip --disable-pip-version-check --no-cache-dir install -r requirements.txt

COPY ./resources /app/resources/
COPY ./src /app/src/
COPY ./tests /app/tests/
COPY ./.coveragerc /app/
RUN py.test --cov-config=/app/.coveragerc \
            --cov-report=term-missing \
            --cov-branch \
            --cov=/app/src/ \
            --cov=/app/resources/src/ \
            --showlocals \
            --capture=fd \
            -vv \
            /app/tests/
RUN bash -c '[[ -z "${CODECOV_TOKEN}" || -z "${BUILDKITE_TAG:-$BUILDKITE_COMMIT}" ]] || codecov --commit=${BUILDKITE_TAG:-$BUILDKITE_COMMIT}'

FROM python:3.6.5-alpine3.7
MAINTAINER Arik Kfir <arik@kfirs.com>

# setup python & pip dependencies
WORKDIR /deployster/
COPY --from=build /app/requirements.txt /deployster/
RUN apk --no-cache --update add bash docker jq
RUN pip3 --disable-pip-version-check --no-cache-dir install -r ./requirements.txt

# setup environment & version
ENV PYTHONIOENCODING="utf-8"
ENV PYTHONPATH="/deployster/lib"
ENV PYTHONUNBUFFERED="1"
ARG VERSION="0.0.0"
RUN echo "${VERSION}" > /deployster/VERSION
COPY --from=build /app/src /deployster/lib
RUN chmod a+x /deployster/lib/deployster.py
ENTRYPOINT ["/deployster/lib/deployster.py"]
