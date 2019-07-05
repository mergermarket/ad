FROM node:12.6-slim
RUN apt-get update && apt-get install -y jq
WORKDIR /opt/active-directory-library
COPY package.json yarn.lock .npmrc ./
RUN yarn
COPY . .
CMD yarn test
