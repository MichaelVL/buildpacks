FROM node:16.13.1-alpine3.14 AS builder
WORKDIR /usr/src/app
COPY package*.json ./
COPY tsconfig.json .
COPY src src
RUN npm ci
RUN npm run build
RUN npm prune --production

FROM node:16.13.1-alpine3.14
WORKDIR /usr/src/app
USER node
ENV NODE_ENV production
COPY --from=builder /usr/src/app/dist/ ./dist
COPY --from=builder /usr/src/app/node_modules/ ./node_modules
EXPOSE 8000
CMD [ "node", "/usr/src/app/dist/main.js" ]
