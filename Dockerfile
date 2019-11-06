FROM python:3.6
LABEL maintainer="Vivek Katial <vivekkatial@gmail.com>"

# SET UP
ENV MLFLOW_VERSION 1.4.0
ENV TERM linux
ENV BUCKET s3://testBucket/
ENV MLFLOW_S3_ENDPOINT_URL https://objects.storage.unimelb.edu.au
# ENV BACKEND_URI db_type://<user_name>:<password>@<host>:<port>/<database_name>

#####################################################################
# AWS
#####################################################################

# install AWS CLI
WORKDIR /root
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
RUN unzip awscli-bundle.zip
RUN ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

# copy AWS credentials (Make sure credentials aren't tracked)
COPY .aws /root/.aws

#####################################################################
# MLFLOW
#####################################################################

RUN pip install mlflow==$MLFLOW_VERSION
RUN mkdir -p /mlflow/

ADD extra-requirements.txt /mlflow/

WORKDIR /mlflow/

# Install extra-requirments
RUN pip install -r extra-requirements.txt

# Expose Port 8080
EXPOSE 5000

# Deploy
CMD mlflow server \
    --default-artifact-root $BUCKET \
    --host 0.0.0.0