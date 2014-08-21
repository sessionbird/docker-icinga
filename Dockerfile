FROM      	centos:centos7
MAINTAINER 	Sessionbird "hello@sessionbird.com"

RUN yum -y install httpd gcc glibc glibc-common gd gd-devel libjpeg libjpeg-devel libpng libpng-devel net-snmp net-snmp-devel net-snmp-utils
RUN yum -y install wget tar
RUN yum -y groupinstall "Development Tools"
RUN useradd icinga
RUN groupadd icinga-cmd
RUN usermod -a -G icinga-cmd icinga
RUN usermod -a -G icinga-cmd apache

# install
RUN wget https://github.com/Icinga/icinga-core/releases/download/v1.11.5/icinga-1.11.5.tar.gz -O /tmp/icinga.tar.gz
RUN wget http://www.nagios-plugins.org/download/nagios-plugins-2.0.3.tar.gz -O /tmp/nagios-plugin.tar.gz
RUN cd /tmp && tar zxf icinga.tar.gz && rm -f icinga.tar.gz
RUN cd /tmp && tar zxf nagios-plugin.tar.gz && rm -f nagios-plugin.tar.gz
RUN cd /tmp/icinga* && ./configure --with-command-group=icinga-cmd --disable-idoutils && make all && make fullinstall && make install-config
RUN cd /tmp/icinga* && make cgis && make install-cgis && make install-html && make install-webconf
RUN cd /tmp/nagios* && ./configure --prefix=/usr/local/icinga --with-cgiurl=/icinga/cgi-bin --with-nagios-user=icinga --with-nagios-group=icinga && make && make install
RUN /usr/local/icinga/bin/icinga -v /usr/local/icinga/etc/icinga.cfg
RUN chkconfig --add icinga
RUN chkconfig --level 35 icinga on

ADD htpasswd.users /usr/local/icinga/etc/htpasswd.users
ADD contacts.cfg usr/local/icinga/etc/objects/contacts.cfg

ADD start.sh /start.sh
CMD /bin/sh /start.sh

EXPOSE 80
