# differences between dev and build files:
    # dev needs dependencies so that it can build and rebuild files
    # build does not need this. It has pre-created files to serve
# we need alpine but we also need nginx
# can we make two base images?
    # yes! "multi-step build process"
        # we can make one image and build something on it
        # we can make a second image and copy the thing we built from the first image onto it
    
# build image: goal: build files required for react app to work
FROM node:alpine

WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build


# prod image: goal: start with nginx. copy required files created from the build image
FROM nginx
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html
