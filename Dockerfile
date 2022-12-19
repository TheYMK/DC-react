# Start builder
FROM node:16-alpine as builder 

WORKDIR /usr/src/app

COPY ./package.json .
RUN npm install
COPY ./ ./
RUN npm run build

# End builder
# Start runner (PS: Nginx doesn't need a startup command it knows how to start itself)
FROM nginx
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
# End runner