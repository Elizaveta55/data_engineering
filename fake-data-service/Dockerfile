FROM python:3.9.7-slim-buster
RUN apt update
RUN apt install -y git
COPY ./app /app
WORKDIR /app
COPY requirements.txt /app
RUN pip install -U pip
RUN pip install -r /app/requirements.txt
EXPOSE 5055
CMD ["python", "main.py"]
