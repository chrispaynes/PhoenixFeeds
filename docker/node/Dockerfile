FROM node:8-alpine as build-stage

WORKDIR /app

COPY ./app/phxfeeds_ui/package.json ./app/phxfeeds_ui/package-lock.json ./

RUN npm config set depth 0 \
	&& npm cache clean --force \
	&& npm i

COPY ./app/phxfeeds_ui .

CMD npm run start
