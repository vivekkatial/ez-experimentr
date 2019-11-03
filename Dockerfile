FROM python:3.6
LABEL maintainer="Vivek Katial <vivekkatial@gmail.com>"

ENV MLFLOW_VERSION 1.4.0
ENV BACKEND_URI db_type://<user_name>:<password>@<host>:<port>/<database_name>
ENV TERM linux
ENV BUCKET bucket

RUN pip install mlflow==$MLFLOW_VERSION

RUN mkdir -p /mlflow/

ADD extra-requirements.txt /mlflow/

WORKDIR /mlflow/

RUN pip install -r extra-requirements.txt

EXPOSE 5000

CMD mlflow server \
  --host 0.0.0.0
