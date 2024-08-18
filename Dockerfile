# base this image on an official Noe.js long term support image. 

FROM node:18.16.0-alpine

# install Tini using Alpine Linux's package manager, apk. 

RUN apk add --no-cache tini

# use tini as the init process. tini will take care of system stuff 
# for us, like forwarding signals and reaping zmobie prcoesses 

ENTRYPOINT [ "/sbin/tini", "--" ]

#install fortune
RUN apk add --no-cache fortune 

# create a working directory for our application 
RUN mkdir -p /app
WORKDIR /app 


# install the project's NPM dependencies 
COPY package.json /app/
RUN npm --silent install
RUN mkdir /deps && mv node_modules /deps/node_modules

# set enviornment variables to point to the installed NPM modules 
ENV NODE_PATH=/deps/node_modules \
PATH=/deps/node_modules/.bin:$PATH

#copy our application files into the imag
COPY . /app

#switch to a non-privileged user for running commands 
RUN chown -R node:node /app /deps 
USER node 

# expose container port 3000 
EXPOSE 3000

# set the default command to user for 'docker run'.
#'npm start' simple starts our server . 
CMD [ "npm", "start"]
