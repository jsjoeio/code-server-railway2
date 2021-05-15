FROM codercom/code-server:3.9.3

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
RUN sudo apt install -y vim

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - 
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN sudo apt update
RUN sudo apt install -y yarn
RUN yarn --version

# Wooo - doing this to trigger rebuild
