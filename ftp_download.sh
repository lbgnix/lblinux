#!/bin/bash
#cd /var/www/html/iiflcms/data/iifl/stock_idea/
TIME=`date +%d-%m-%y` 
FILENAME=/home/nikhilt/script/logs/"reuters_ftp_log-$TIME.txt"
DelZip="/home/nikhilt/script/*.zip"
DelPDF="/home/nikhilt/script/pdf_new"
DelXML="/home/nikhilt/script/xml_new"

#Deleting existing xml_new and pdf_new directories
#	if [ -f $DelPDF  ] &&  [ -f $DelXML  ]; then
     
#	echo "When file is  "`date`" Deleting existing xml_new and pdf_new directories" >> $FILENAME

	rm -rf /home/nikhilt/script/xml_new

	rm -rf /home/nikhilt/script/pdf_new

#	else
#	echo "file is not exist on mention path(/home/nikhilt/script/)  "`date`" " >> $FILENAME
#	fi

#Deleteing the old existing Zip file whiche was doenloaded priviously.
	if [ -f $DelZip ]; then
	 rm -rf $DelZip
	echo "We are  "`date`" Deleting existing old zip donloaded files from reuters" >> $FILENAME
	else
	echo "file is not exist on mention path(/home/nikhilt/script/)  "`date`" " >> $FILENAME
	fi 

HOST='stockreplus.com'
USER='IIFL'
PASSWD='fl5^nsX%eF'

cd /home/nikhilt/script/
echo "Start Downloading ZIP Files Via FTP  "`date`" provided by Link reuters"  >>  $FILENAME
ftp -in  $HOST  << SCRIPTEND
user $USER $PASSWD 
binary
mget *.zip 
SCRIPTEND
exit

