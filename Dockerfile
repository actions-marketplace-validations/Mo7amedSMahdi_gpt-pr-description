FROM python:3.11-slim-buster

RUN apt-get update
RUN apt-get -y install jq

COPY entrypoint.sh entrypoint.sh
COPY generate_pr.py generate_pr.py
COPY requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

ENTRYPOINT ["entrypoint.sh"]