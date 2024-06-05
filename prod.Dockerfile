# 使用 Node.js 18 的官方 Alpine Linux 镜像作为基础镜像
FROM node:18-alpine AS base

# 创建一个构建阶段，基于 base 镜像
FROM base AS builder

# 设置工作目录
WORKDIR /app

# 复制项目文件到工作目录
COPY . .

# 安装依赖，使用指定的 npm 镜像源
RUN npm i --registry=https://registry.npmmirror.com;

# 构建应用
RUN npm run build;

# 创建一个运行阶段，基于 base 镜像
FROM base AS runner

# 设置工作目录
WORKDIR /app

# 从构建阶段复制构建产物到运行阶段
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static

# 禁用 Next.js 的遥测功能
ENV NEXT_TELEMETRY_DISABLED 1

