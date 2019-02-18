
#!/bin/bash

for i in 10.101.1.2
do
echo $i


DATE=$(date -d '-2 day' '+%Y-%m-%d')
echo $DATE
year=`date +%Y`
month=`date +%m`
echo $year $month
log_path="/var/log/syslog-ng/firewall/$i/$year/$month/$i-$DATE.log"

tar cvf /var/log/syslog-ng/firewall/$i/$year/$month/$i-$DATE.log.tar.gz $log_path 
