FROM python:3.8

# Override the base log level (info).
ENV NPM_CONFIG_LOGLEVEL warn
WORKDIR /app

# Adding trusting keys to apt for repositories
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

# Updating apt to see and install Google Chrome
RUN apt-get -y update && \
  apt-get install -y google-chrome-stable && \
  apt-get install -yqq unzip

# Download the Chrome Driver
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip && \
  unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/


COPY . /app

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Set display port as an environment variable
ENV DISPLAY=:99

RUN chown -R 1000:1000 /app
USER 1000
CMD ["python", "./export.py"]


#docker build -t 28dexport .
#docker run  -v $(pwd):/app/output 28dexport
#docker run --rm -it --entrypoint=/bin/bash -v "$(pwd):/app/output" 28dexport

