FROM node:lts-alpine

ENV NODE_ENV production
ENV NPM_CONFIG_LOGLEVEL warn

RUN mkdir /home/node/app/ && chown -R node:node /home/node/app

WORKDIR /home/node/app

# 复制文件并改变所有权
COPY --chown=node:node package.json package-lock.json ./

USER node

# 运行 npm install
RUN npm install --production

# 复制其余文件并改变所有权
COPY --chown=node:node . .

EXPOSE 80

CMD ["npm", "start"]
