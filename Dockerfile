# Use the official Ruby image as the base image
FROM ruby:2.7.0-alpine

RUN apk update && apk add --no-cache build-base
RUN apk add nodejs
RUN apk add tzdata


# Set the working directory in the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install dependencies
RUN gem install bundler
# RUN apk add ruby-full build-essential
# RUN gem install racc -v '1.6.2'
RUN bundle install

# Copy the rest of the application code to the container
COPY . .

# Set environment variables
ENV RAILS_ENV=development

# Expose a port
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
    
