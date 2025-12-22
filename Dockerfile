# Python image to use.
FROM python:3.14-slim

# Set environment variable to ensure logs are output to the console
ENV PYTHONUNBUFFERED=1

# Set the working directory to /app
WORKDIR /app

COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt

# copy the requirements file used for dependencies
COPY src/ ./src/
COPY static/ ./static/

# Specify the command to run the application. Also, ensure the main script checks which host the application will run on
CMD ["uvicorn", "src.main:main_app", "--host", "0.0.0.0", "--port", "8080"]
#CMD ["uvicorn", "src.main:main_app", "--host", "0.0.0.0", "--port", "8080", "--ssl-keyfile", "/cert/localhost+2-key.pem", "--ssl-certfile", "/cert/localhost+2.pem"]
# ENTRYPOINT vs CMD: back to basics
