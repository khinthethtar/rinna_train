FROM python:3.8

EXPOSE 5000
ENV PORT=8080

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTE\CODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

WORKDIR /app
COPY . /app

ENV ENV=dev

# Install pip requirements
COPY requirements.txt .
RUN apt-get -y update
RUN apt-get -y install git
RUN python -m pip install -r requirements.txt

CMD exec gunicorn --bind :$PORT  --workers 1 --threads 8 --timeout 0 main:app