FROM node:16.10.0-alpine3.12 AS builder
WORKDIR /usr/src/app
COPY package*.json ./
COPY tsconfig.json .
COPY src src
RUN npm install
RUN npm run build

FROM node:16.10.0-alpine3.12
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/dist/ ./dist
COPY --from=builder /usr/src/app/node_modules/ ./node_modules
ENV NODE_ENV production
USER node
EXPOSE 5010
CMD [ "node", "/usr/src/app/dist/main.js" ]

