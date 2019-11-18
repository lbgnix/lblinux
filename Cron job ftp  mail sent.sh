#!/bin/bash

#Title          : emailnotification .sh
#Author         : LALBAHADUR VISHWAKARMA
#Purpose        : This script is design to executed once a day for downloading 2 zip files from Stockreportsplus.com via ftp after downloding zip file this will be send email notification of success & failure log.
#Date           : Mon Aug 19 11:16:55 AM IST 2019
#Version        : 0.1
#BASH_VERSION   : Tested on GNU bash, version 4.1.2
#OS Specs       : CentOS release 6.10

umask 0
now=$(date  '+%A %Y-%m-%d %T')
sENDE="/bin/sendEmail"
PoSMTP="192.168.112.11:25"
FEMID="alerts@gmail.com"
TOID="lalbahadur.vishwakarma@gmail.com"
TOID="xyz@gmail.com"
GCPIP=`hostname -I | awk '{print $1}'`
eGCPHost=`hostname`
MAILSUB="eNotification  TR StockReport PDF and XML CRON Execution report ${now} Hrs\n\n"
MSGBODY="Hello Team,\n\n eNotification for TR StockReport PDF and XML CRON ${now} Hrs\n\n"
ReGards="Regards,\nLALBAHADUR V.\nMobile:- 7867878576"

SUC=""

# script to download zip files from stock reports plus server
#timeout 60 /bin/bash  /home/nikhilt/script/ftp_download.sh
ls -l /home/nikhilt/script/IIFL*
# condition to check whether download was successful

echo $?
if [ $? -eq 0 ]; then

        # Storing downloaded file names in a variable
        List=`ls  /home/nikhilt/script/*.zip | wc -l`

        # creating new pdf and xml directories
        mkdir -p /home/nikhilt/script/{xml_new,pdf_new}

        # unzip xml zip in xml_new directory
        XMLUNZIP="$(unzip /home/nikhilt/script/IIFL_META* -d /home/nikhilt/script/xml_new)"

 XMLUNZIP="$(unzip /home/nikhilt/script/IIFL_META* -d /home/nikhilt/script/xml_new)"

        echo "$XMLUNZIP"


                # unzip pdf zip in pdf_new directory
                PDFUNZIP="$(unzip /home/nikhilt/script/IIFL_PDF* -d /home/nikhilt/script/pdf_new)"

                echo "$PDFUNZIP"

                if [ $? -eq 0 ]; then

                        PHPEXPORT="$(/usr/bin/php  /var/www/html/iiflcms/scripts/reuters_stock_ideas.php)"

                        echo "$PHPEXPORT"


                                echo "PHP Export successful"

                        else

                                echo "PHP Export failed"



        fi

        #`unzip /home/nikhilt/IIFL_META* -d /home/nikhilt/script/xml_new`
         # /usr/bin/unzip  /home/nikhilt/script/IIFL_META* -d /home/nikhilt/script/xml_new



#       pdfUnzip =`unzip /home/nikhilt/IIFL_PDF* -d /home/nikhilt/script/pdf_new`

        # check if both extraction were successful
##      if [ $xmlUnzip -eq 0 ] && [ $pdfUnzip -eq 0 ]; then
                # /usr/bin/php  /var/www/html/iiflcms/scripts/reuters_stock_ideas.php
        PDFLiSt=`ls  /home/nikhilt/script/pdf_new/*.pdf |wc -l`

         MSGBODY+="All zip files downloaded successfully\n\nList of total Downloaded  files:- \n${List}\nList of PDF Files:- ${PDFLiSt}"
         MAILSUB="eNotification  TR StockReport PDF and XML CRON Executed successfully ${now} Hrs"
else
         MSGBODY+="There was an error while downloading the zip files from FTP"
         MAILSUB="eNotification  TR StockReport PDF and XML CRON Execution failed ${now} Hrs"
fi
 $sENDE -u $MAILSUB -f $FEMID -t $TOID -m "${MSGBODY}\n\nGCPIP-: ${GCPIP}\nGCPServerHost-: ${eGCPHost}\n\n\nThanks,\n\n${ReGards}\n" -s ${PoSMTP}
exit 
