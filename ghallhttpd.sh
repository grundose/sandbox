#! /bin/bash
#Notes:
# root@ghall-vm01 conf]# httpd -S | grep *.conf | sed -e 's/.*namevhost//' -e 's/(//' -e 's/)//' -e 1d| gawk -F: '{ print $1 }'
# www.whereisbuttons.com /etc/httpd/conf.d/main.conf
# www.wiki.whereisbuttons.com /etc/httpd/conf.d/wiki.conf
#
# [root@ghall-vm01 conf]# httpd -S | grep *.conf | sed -e 's/.*namevhost //' -e 's/(//' -e 's/)//' -e 1d -e 's/ .*//'
# www.whereisbuttons.com
# www.wiki.whereisbuttons.com
#
#

echo "Building Vhost Array"

#Read namevhost in as array
echo "Available Domains"
N=0
for i in  $(httpd -S | grep *.conf | sed -e 's/.*namevhost //' -e 's/(//' -e 's/)//' -e 1d -e 's/ .*//') ; do
   
      testarray[$N]="$i"
      echo "$N = $i"     
       
  let "N= $N + 1"

done

echo "Please select domain"
read USERSELECT


printf "SELECTED: "${testarray[$USERSELECT]}
printf "\n"
##Set URL Variable for further poking
URL=${testarray[$USERSELECT]}
CONF=$(httpd -S | grep $URL |  sed -e 's/.*(//' -e 's/:.*//')
DOCROOT=$(grep Document $CONF | sed -e 's/.* //')
IP=$(grep VirtualHost $CONF | sed -e 's/.*VirtualHost //' -e 's/>.*//'  -e 2d)
LOG=
printf "PATH TO CONF: $CONF \nDOC ROOT: $DOCROOT \nIP/PORT $IP \n"

printf "**************************** \n Select function: \n 1) Hits by IP \n 2)Hits by User Agent \n"
read OPERATION

