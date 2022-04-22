FROM python:3.9.6-slim-buster

ENV PYTHONUNBUFFERED=1 \
 PYTHONDONTWRITEBYTECODE=1 \
 FLASK_APP=js_example

ARG USER=api 

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    && groupadd --gid 2000 $USER \
    && useradd --uid 2000 \
            --gid $USER \
            --shell /bin/bash \
            --create-home $USER

WORKDIR /usr/src/app

COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip && \
    pip install  -r requirements.txt && \
    chown -R $USER:$USER /usr/src/app && \
    apt install curl -y
COPY --chown=api:api . .
#USER $USER
EXPOSE 5000
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
