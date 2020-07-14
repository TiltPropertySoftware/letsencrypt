FROM python:3.8-slim
RUN pip install --no-cache-dir certbot certbot-dns-route53
