FROM python

# Install Flask and Gunicorn
RUN pip install Flask gunicorn requests redis

# Create a group and user for running Gunicorn
RUN groupadd -r gunicorn && useradd -r -g gunicorn gunicorn

# Set working directory
WORKDIR /app

# Copy the app code
COPY app /app

#Copy switch env to dev code
COPY cmd.sh /

# Change ownership of the app folder to the gunicorn user
RUN chown -R gunicorn:gunicorn /app

# Switch to the gunicorn user
USER gunicorn

# Expose the ports
EXPOSE 9090

# Start the application
CMD ["/cmd.sh"]
