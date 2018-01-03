Docker Image: Enemy Territory Legacy (etlegacy)
===============================================

Docker container for ET: Legacy dedicated game server.

Run with default settings
-------------------------

Per default, the server is configured to run with the default name "ET Legacy Host" and the rcon password "etlegacy".  
In order to start the server for a quick match, just create a new container (running in the background due to the `-d` parameter):

    docker run --name enemyterritory -p 27960:27960/udp -d metaxmx/etlegacy


Once the server is created with a given name, it can be stopped, removed and restarted with the general docker commands:

    # Stop:
    docker stop enemyterritory
    
    # Start (if it was stopped)
    docker start enemyterritory
    
    # Restart
    docker restart enemyterritory
    
    # Remove
     docker rm -f enemyterritory
    

Run with custom server settings
-------------------------------

The server configuration is provided in a Docker Volume,
so it can be edited and will be applied after the next restart of the server.

In order to configure the settings, mount the volume path `/opt/etlegacy/conf` to a directory on your host.

After the first start, the Enemy Territory server will provide the default configuration in this directory for you to change as `etl_server.cfg`. 

*Hint: If you don't provide the server config by yourself, you need to have this directory writable by the enemy territory user (user id 800)*

    mkdir /my/et/config
    chmod a+w /my/et/config
    docker run --name enemyterritory -p 27960:27960/udp -v /my/et/config:/opt/etlegacy/conf -d metaxmx/etlegacy
    # Make your changes
    vim /my/et/config/etl_server.cfg
    docker restart enemyterritory


Auto-Restart
------------

If you want the game server to automatically restart, e.g. when the operating system is rebooted, add the parameter "restart=always" to the `docker run` command:

    docker run --name enemyterritory --restart=always -p 27960:27960/udp -d metaxmx/etlegacy
    
