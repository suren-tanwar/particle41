FROM node:20-alpine

WORKDIR /app

COPY package.json ./
RUN npm install --only=production

COPY . .

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

USER appuser

EXPOSE 8080

CMD ["node", "index.js"]