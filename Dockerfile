
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx

#this is required for elastic beanstalk to expose the file
# https://www.udemy.com/course/docker-and-kubernetes-the-complete-guide/learn/lecture/11437146#questions
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html