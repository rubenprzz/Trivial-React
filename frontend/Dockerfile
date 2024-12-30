FROM node:22.12.0 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

FROM node:22.12.0

WORKDIR /app

RUN npm install -g serve

COPY --from=build /app/build ./build

EXPOSE 3001

CMD ["serve", "-s", "build", "-l", "3001"]
