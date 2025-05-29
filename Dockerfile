# Stage 1: Builder
FROM python:3.11-slim as builder
WORKDIR /app
COPY app/requirements.txt .
RUN pip install --upgrade pip && pip install --user -r requirements.txt

# Stage 2: Runtime
FROM python:3.11-slim
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY app /app
ENV PATH=/root/.local/bin:$PATH
USER nobody
EXPOSE 5000
CMD ["python", "main.py"]