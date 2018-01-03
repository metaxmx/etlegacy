############################################################
# Dockerfile to run ET: Legacy containers
# Based on Debian image
############################################################
FROM debian:stretch
MAINTAINER Christian Simon <mail@christiansimon.eu>

ENV APP_USER etded
ENV APP_USER_ID 800
ENV APP_HOME /opt/etlegacy

# Install prereqs
RUN apt-get update && apt-get install -y \
  p7zip-full \
  curl \
  && rm -rf /var/lib/apt/lists/*

# Create dedicated user
RUN groupadd -r --gid "${APP_USER_ID}" "${APP_USER}" \
  && useradd -r --uid "${APP_USER_ID}" -g "${APP_USER}" -m "${APP_USER}" \
  && mkdir -p "${APP_HOME}" \
  && chown "${APP_USER}":"${APP_USER}" "${APP_HOME}"

# Set the user to run etlegacy as daemon
USER ${APP_USER}
WORKDIR ${APP_HOME}

# Install Wolfenstein: Enemy Territory Legacy
RUN curl https://www.etlegacy.com/download/file/87 | tar xvz; mv etlegacy-v2.75-x86_64 ${APP_HOME}
RUN curl -o temp.exe http://trackbase.eu/files//et/full/WolfET_2_60b_custom.exe; 7z e temp.exe -o${APP_HOME}/etmain etmain/pak*.pk3; rm temp.exe
RUN echo "set sv_allowDownload \"1\"" >> ${APP_HOME}/etmain/etl_server.cfg
RUN echo "set rconpassword \"etlegacy\"" >> ${APP_HOME}/etmain/etl_server.cfg

# Port to expose
EXPOSE 27960/udp

# Set the entrypoint to etlegacy script
ENTRYPOINT ./etlded_bot.sh
