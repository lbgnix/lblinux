#!/bin/bash

#Title		: emailnotification .sh
#Author  	: LALBAHADUR VISHWAKARMA
#Purpose 	: This script is design to executed once a day for downloading 2 zip files from Stockreportsplus.com via ftp after downloding zip file this will be send email notification of success & failure log. 
#Date    	: Mon Aug 19 11:16:55 AM IST 2019
#Version	: 0.1
#BASH_VERSION   : Tested on GNU bash, version 4.1.2
#OS Specs 	: CentOS release 6.10

PROCST=$(type -p ps)
now=$(date  '+%A %Y-%m-%d %T')
sENDE="/bin/sendEmail"
PoSMTP="192.26.3.11:25"
FEMID="alerts@indiainfoline.com"
TOID="lalbahadur.vishwakarma@gmail.com"
#TOID="xyz@gmail.com"
GCPIP=`hostname -I | awk '{print $1}'`
eGCPHost=`hostname`

PCNT=`${PROCST} -elf | grep -i httpd | wc -l`
        if [ ${PCNT} -ge 5 ]; then

                FREEMEM=`free -m | awk 'NR==2 {print $4}'`
                FREESWAP=`free -m | awk 'NR==4 {print $4}'`
                MAILSUB="eNotification  TR StockReport PDF and XML CRON Executed successfully ${now} Hrs"
                MSGBODY="Hello Team,\n\n eNotification  TR StockReport PDF and XML CRON Executed successfully ${now} Hrs"
                ReGards="Regards,\nLALBAHADUR V.\nMobile:- 9619348640"
                $sENDE -u $MAILSUB -f $FEMID -t $TOID -m "${MSGBODY}\n\nGCPIP-: ${GCPIP}\nGCPServerHost-: ${eGCPHost}\nFreeMEM-:${FREEMEM} MB\nFreeSWAP-:${FREESWAP} MB\n\nThanks,\n\n${ReGards}\n" -s ${PoSMTP}
                if [ ${PCNT} -ge 30 ]; then
                /usr/bin/top -n 3 -b > /tmp/top-output`date +%Y%m%d%M`.txt
                $sENDE -u $sENDE -f $FEMID -t $TOID -m "${GCPIP} Process Attachment !!" -a /tmp/top-output`date +%Y%m%d%M`.txt -s ${PoSMTP}
                fi
                exit 0
        fi
