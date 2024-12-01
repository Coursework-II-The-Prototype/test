FROM fedora:40

RUN dnf update -y \
    && dnf install -y \
    python3.12 \
    python3.12-pip \
    curl 

RUN curl -sSL https://install.python-poetry.org | python3.12 - --version 1.8.4

WORKDIR /app

COPY pyproject.toml poetry.lock /app/

RUN /root/.local/bin/poetry remove black flake8 pytest
RUN /root/.local/bin/poetry install --no-dev

COPY test.py /app/

CMD ["/root/.local/bin/poetry", "run", "python3.12", "test.py"]