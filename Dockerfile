# Python image to use.
FROM python:3.14-slim

# Устанавливаем переменную окружения для обеспечения вывода логов в консоль
ENV PYTHONUNBUFFERED=1

# Set the working directory to /app
WORKDIR /app

COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt

# copy the requirements file used for dependencies
COPY src/ ./src/
COPY static/ ./static/

# Указываем команду для запуска приложения обязательно, а так же в основном скрипте, должна быть проверка с указанием на каком хосте будет запускаться приложение
CMD ["uvicorn", "src.main:main_app", "--host", "0.0.0.0", "--port", "8080"]
#CMD ["uvicorn", "src.main:main_app", "--host", "0.0.0.0", "--port", "8080", "--ssl-keyfile", "/cert/localhost+2-key.pem", "--ssl-certfile", "/cert/localhost+2.pem"]
# ENTRYPOINT vs CMD: назад к основам
