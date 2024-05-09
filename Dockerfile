FROM node:20 AS base

COPY . .
RUN npm i
RUN npm run build:docs
CMD npx serve dist/examples/typescript/
