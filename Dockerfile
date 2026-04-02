FROM python:3.12-alpine

WORKDIR /app

RUN pip install uv
ENV UV_SYSTEM_PYTHON=1
ENV UV_PROJECT_ENVIRONMENT="/usr/local/"

COPY pyproject.toml uv.lock ./

RUN uv sync --frozen --no-dev


COPY src ./src

EXPOSE 8000

CMD ["gunicorn", "src.main:app", "--bind", "0.0.0.0:8000", "--workers", "2", "-k", "uvicorn.workers.UvicornWorker"]