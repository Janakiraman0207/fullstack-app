# Step 1: Build frontend
FROM node:18 AS frontend-build
WORKDIR /app/frontend
COPY frontend/package.json .
RUN npm install
COPY frontend/. .
RUN npm run build


# Step 2: Setup backend + serve frontend
FROM node:18
WORKDIR /app

# Copy backend
COPY backend/package.json .
RUN npm install
COPY backend/. .

# Copy frontend build output into backend public folder
RUN mkdir -p /app/public
COPY --from=frontend-build /app/frontend/build /app/public

EXPOSE 5000

CMD ["npm", "start"]
