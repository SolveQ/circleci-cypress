FROM circleci/node:10.0.0

RUN sudo apt-get update --fix-missing
RUN sudo apt-get install xvfb libgtk2.0-0 libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2

RUN sudo mkdir /usr/src/app
WORKDIR /usr/src/app

RUN sudo yarn add cypress@3.1.0

ONBUILD COPY cypress.json /usr/src/app/cypress.json
ONBUILD COPY ./e2e /usr/src/app/e2e

ONBUILD RUN sudo ./node_modules/.bin/cypress verify

ONBUILD RUN sudo Xvfb :1 -screen 0 '1280x1024x16' -ac &> /dev/null

ENV DISPLAY=1
