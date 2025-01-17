FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
COPY loop.sh /loop.sh
RUN <<EOF
    apt-get update
    apt-get install -y apache2 php php-odbc php-xdebug git grc
    echo "xdebug.start_with_request=yes" >> xdebug.ini
    echo "xdebug.mode=debug" >> xdebug.ini
    # pecl install sqlsrv pdo_sqlsrv
    # printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php/8.3/mods-available/sqlsrv.ini
    # printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php/8.3/mods-available/pdo_sqlsrv.ini
    # phpenmod sqlsrv pdo_sqlsrv
    # May not be necessary
    # a2dismod mpm_event
    # a2enmod mpm_prefork
    # a2enmod php
    # apt autoremove php-dev unixodbc-dev
    if ! [[ "16.04 18.04 20.04 22.04" == *"$(lsb_release -rs)"* ]];
    then
        echo "Ubuntu $(lsb_release -rs) is not currently supported.";
        exit;
    fi

    curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc

    curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list

    sudo apt-get update
    sudo ACCEPT_EULA=Y apt-get install -y msodbcsql17
    # optional: for bcp and sqlcmd
    sudo ACCEPT_EULA=Y apt-get install -y mssql-tools
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
    source ~/.bashrc
    # optional: for unixODBC development headers
    sudo apt-get install -y unixodbc-dev

    mkdir -p /inc/c:/xampp/inc/
    ln -s /inc/c: /inc/C:

EOF
CMD ["/loop.sh"]
