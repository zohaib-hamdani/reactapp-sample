FROM node:18-alpine AS base
WORKDIR /app1
COPY package.json .
COPY package-lock.json .
RUN npm install
COPY . .
RUN npm run build

FROM node:18-alpine AS final
WORKDIR /app2
COPY --from=base /app1/build ./build
EXPOSE 3000
CMD ["npx","serve", "-l", "3000", "-s", "build"]
