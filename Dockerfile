FROM python:3.9

RUN apt-get update && apt-get install -y \
    gdal-bin \
    libgdal-dev \
    binutils \
    libproj-dev \
&& rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN pip install pipenv

COPY Pipfile .
COPY Pipfile.lock .

RUN pipenv install --system --deploy --ignore-pipfile

COPY . .

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

