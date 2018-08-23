FROM circleci/node:10.0.0

USER root

RUN sudo apt-get update --fix-missing
RUN sudo apt-get install xvfb libgtk2.0-0 libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2

RUN sudo mkdir /usr/src/app
WORKDIR /usr/src/app

RUN sudo yarn add cypress@3.1.0

COPY ./cypress.json /usr/src/app/cypress.json
COPY ./e2e /usr/src/app/e2e

RUN sudo Xvfb :1 -screen 0 '1280x1024x16' -ac &> /dev/null

ENV DISPLAY=1
