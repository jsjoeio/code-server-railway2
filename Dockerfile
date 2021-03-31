FROM codercom/code-server:3.9.2

USER coder

# Apply VS Code settings
COPY settings.json .local/share/code-server/User/settings.json

# Use bash shell
ENV SHELL=/bin/bash

# Fix permissions
RUN sudo chown -R coder:coder /home/coder/.local

# Use our custom entrypoint script first
COPY railway-entrypoint.sh /usr/bin/railway-entrypoint.sh
ENTRYPOINT ["/usr/bin/railway-entrypoint.sh"]

# Install NodeJS
RUN sudo curl -fsSL https://deb.nodesource.com/setup_15.x | sudo bash -
RUN sudo apt-get install -y nodejs

# Wooo - doing this to trigger rebuild
