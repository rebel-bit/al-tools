#!/bin/bash

######################################################################
# cms_sc4nn3r
# simple scanner-script www + mysql
######################################################################

######################################################################
# last modify: 11.09.2017
# bug or anything: d43M0n23@3xpl0it.com
######################################################################
# TODO EXAMPLE:
#
######################################################################
#
######################################################################
# Bash sTyl3!
clear='\033[0m'			#alle Attribute zurücksetzen
bold='\033[1m'			#Fettschrift
underline='\033[4m'		#Unterstreichen
blinken='\033[5m'		#Blinken
invers='\033[7m'		#inverse Darstellung
black='\033[30m'		#Schriftfarbe schwarz
red='\033[31m'			#Schriftfarbe rot
green='\033[32m'		#Schriftfarbe grün
yell='\033[33m'			#Schriftfarbe gelb
blue='\033[34m'			#Schriftfarbe blau
mag='\033[35m'			#Schriftfarbe magenta
turk='\033[36m'			#Schriftfarbe türkis
white='\033[37m'		#Schriftfarbe weiß
#######################################################################

##Variablen
DATE=$(date +%F)
version=v1.0
vdate=13.09.2017

## INSTALL & UPDATE START ##
# Local Destination
INSTALL_DIR=/usr/share/cms_sc4nn3r

#INSTALL
if [ ! -d $INSTALL_DIR ]; then
echo -e "\n${green} + -- --=[This is your first run of the cms_sc4nn3r script${clear}"
echo -e "${green} + -- --=[This script will install cms_sc4nn3r under $INSTALL_DIR.${clear}"
echo -e "${green} + -- --=[After install you can use the command 'cms_sc4nn3r' Server/System wide and remove the downloaded git folder${clear}"

sleep 2
mkdir -p $INSTALL_DIR 2> /dev/null
cp -Rf $PWD/* $INSTALL_DIR 2> /dev/null
rm -f /usr/bin/cms_sc4nn3r
ln -s $INSTALL_DIR/cms_sc4nn3r /usr/bin/cms_sc4nn3r
echo -e "${green} + -- --=[Installation Finish.${clear}"
sleep 2
fi

#Latest release
LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' https://github.com/d43M0n23/sc4nn3r/releases/latest)
LATEST_VERSION=$(echo $LATEST_RELEASE | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')

#UPDATE NEW VERSION
if [ "$LATEST_VERSION" != "$version" ]; then
echo -e "\n${red}Your Version of Cms_sc4nn3r is outdated!${clear}"
echo -e "\n${green}Please use the update function: cms_sc4nn3r --update!${clear}"
sleep 5
fi

#UPDATE
if [ "$1"  = "--update" ]; then
echo -e "\n${turk}You have select the update Feature${clear}"
sleep 2
cd /tmp/
git clone https://github.com/d43M0n23/sc4nn3r.git
cp -Rf sc4nn4r/* $INSTALL_DIR 2> /dev/null
rm -f /usr/bin/cms_sc4nn3r
ln -s $INSTALL_DIR/cms_sc4nn3r /usr/bin/cms_sc4nn3r
echo -e "\n${green}Update finish.Please restart cms_sc4nn3r.${clear}"
rm -r sc4nn3r
exit
fi

#UNINSTALL
if [ "$1"  = "--deinstall" ]; then
echo -e "\n${turk}You have select the deinstall Feature${clear}"
sleep 2
rm -f /usr/bin/cms_sc4nn3r
cd /usr/share/
rm -r cms_sc4nn3r/
cd
exit
fi

## INSTALL & UPDATE ENDE ##

# Email
email=alex@xcoorp.com

# Log & bka-dir check
#if [ ! -f $LOG ]; then touch $LOG; fi
#if [ ! -d $DESTINATION ]; then mkdir $DESTINATION; fi

# DELETE OLD LOGS?
# 1=yes/0=no
kill_logs=0
if [ $kill_logs = 1 ]; then rm *.log; fi

#WORKING DIR
TOPDIR=`pwd`


########  START FUNCTIONS ########
# -------------------------------------------
# send email with report from single scann
# -------------------------------------------
sh_mail () {
mail -s "sc4nn3r: ${scanner}" $email < $scanlog -aFrom:sc4nn3r@3xpl0it.com
}

#################
clear
#################
echo '+-------------------------------------------------+'
echo "|                 __ __             _____         |"
echo "|      __________/ // / ____  ____ |__  /_____    |"
echo "|     / ___/ ___/ // /_/ __ \/ __ \ /_ </ ___/    |"
echo "|    (__  ) /__/__  __/ / / / / / /__/ / /        |"
echo "|   /____/\___/  /_/ /_/ /_/_/ /_/____/_/         |"
echo '+-------------------------------------------------+'
echo "|   Version ${version} (c)opyright 2017 by              |"
echo '|   DaemoN d43M0n23@3xpl0it.com                   |'
echo '+-------------------------------------------------+'
echo '|   This Script is subject to the GPL License!    |'
echo '|   You can copy and change it!                   |'
echo '+-------------------------------------------------+'
echo "|                                Date: ${vdate} |"
echo '+-------------------------------------------------+'
sleep 2
while [ "$attacker" != "q" ]
#clear
echo '+-------------------------------------------------+'
echo '| Own-Scripts, Aux & Scanner-Frames               |'
echo '+-------------------------------------------------+'
echo '| 1.Wpscan. | Wordpress                           |'
echo '| 2.CMSmap. | Wordpress - Joomla - Durpal         |'
echo '| 3.D-TECT. | Wordpress                           |'
echo '| 4.WPSeku. | Wordpress                           |'
echo '| 5.Nikto.  | All                                 |'
echo '| 6.Reverse IP Lookup. | All                      |'
echo '| 7.Joomlavs. | Joomla                            |'
#echo '| 8.Joomscan. | Joomla                            |'
echo '| a.All.                                          |'
echo '| x.Quit.                                         |'
echo '+-------------------------------------------------+'
read -p "Attacker Nr (1-x)? " attacker
if [ $attacker = a ]; then
read -p "Wordpress or Joomla (w/j)? " cms_system
fi
do
case $attacker in
        1)
		echo "Wpscan selected"
		read -p "domain (e.g. google.com)? " wp_domain
		if [ $wp_domain ]; then
		wpscan --update
		wpscan --url $wp_domain --enumerate 2>&1 | tee -a wpscan_${wp_domain}.log
		echo -e "\n${yell}Logfile is saved as wpscan_${wp_domain}.log${clear}\n"
		scanner=Wpscan_${wp_domain}
		scanlog=wpscan_${wp_domain}.log
		#mail -s "sc4nn3r: ${scanner}" $email < $scanlog -aFrom:cms-sc4nn3r@3xpl0it.com
		sh_mail
		else
        	echo -e "\nPlease enter a domain!\n"
		fi
            	;;
        2)
		echo "CMSmap selected"
		read -p "domain (e.g. google.com)? " cms_domain
		if [ $cms_domain ]; then
		python /root/c0r3/09-cms/CMSmap/cmsmap.py -t $cms_domain -o cmsscan_${cms_domain}.log
		echo -e "\n${yell}Logfile is saved as cmsscan_${cms_domain}.log${clear}\n"
                scanner=CMSscan_${cms_domain}
                scanlog=CMSscan_${cms_domain}.log
                sh_mail
                else
                echo -e "\nPlease enter a domain!\n"
                fi
    		;;
        3)
		echo "D-TECT selected"
		python /root/c0r3/09-cms/D-TECT/d-tect.py
#                $scanner = Wpscan_${wp_domain}
#                $scanlog = wpscan_${wp_domain}.log
#                sh_mail
#                else
#                echo -e "\nPlease enter a domain!\n"
#                fi
		;;
        4)
		echo "WPSeku selected"
		read -p "domain (e.g. google.com)? " wpseku_domain
		if [ $wpseku_domain ]; then
		python /root/c0r3/09-cms/WPSeku/wpseku.py -t $wpseku_domain 2>&1 | tee -a wpseku_${wpseku_domain}.log
		echo -e "\n${yell}Logfile is saved as wpseku_${wpseku_domain}.log${clear}\n"
                scanner=WPSeku_${wpseku_domain}
                scanlog=wpseku_${wpseku_domain}.log
                sh_mail
                else
                echo -e "\nPlease enter a domain!\n"
                fi
            	;;
        5)
                echo "Nikto selected"
                read -p "domain (e.g. google.com)? " nikto_domain
		if [ $nikto_domain ]; then
                nikto -host http://$nikto_domain 2>&1 | tee -a nikto_${nikto_domain}.log
		echo -e "\n${yell}Logfile is saved as nikto_${nikto_domain}.log${clear}\n"
                scanner=Nikto_${nikto_domain}
                scanlog=nikto_${nikto_domain}.log
                sh_mail
                else
                echo -e "\nPlease enter a domain!\n"
                fi
                ;;
        6)
                echo "IP Lookup selected"
		read -p "domain or ip (e.g. google.com)? " rev_domain
		if [ $rev_domain ]; then
                php rev3r531p.php $rev_domain 2>&1 | tee -a reverse_${rev_domain}.log
		echo -e "\n${yell}Logfile is saved as reverse_${rev_domain}.log${clear}\n"
                scanner=Reverse_${rev_domain}
                scanlog=reverse_${rev_domain}.log
                sh_mail
                else
                echo -e "\nPlease enter a domain!\n"
                fi
                ;;
        7)
                echo "Joomlavs selected"
                read -p "domain (e.g. google.com)? " joomla_domain
		if [ $joomla_domain ]; then
		ruby /root/c0r3/09-cms/joomlavs/joomlavs.rb -u $joomla_domain --scan-all 2>&1 | tee -a joomla_${joomla_domain}.log
		echo -e "\n${yell}Logfile is saved as joomla_${joomla_domain}.log${clear}\n"
                scanner=Wpscan_${wp_domain}
                scanlog=wpscan_${wp_domain}.log
                sh_mail
                else
                echo -e "\nPlease enter a domain!\n"
                fi
                ;;
#        8) - OUTDATE !!
#                echo "Joomscann selected"
#                read -p "domain (e.g. google.com)? " joomscann_domain
#                joomscan -u $joomscan_domain 2>&1 | tee -a joomscan_${joomscan_domain}.log
#                echo -e "\n${yell}Logfile is saved as joomscan_${joomscan_domain}.log${clear}\n"
#		 GITHUB SOURCE https://github.com/rezasp/joomscan
#                ;;

        a)
                echo "All selected"
                read -p "domain (e.g. google.com)? " all_domain
                if [ $all_domain ]; then
		if [ $cms_system = w ]; then
                wpscan --url $all_domain --enumerate 2>&1 | tee -a all_${all_domain}.log
#		python /root/c0r3/09-cms/CMSmap/cmsmap.py -t $cms_domain -o cmsscan_${cms_domain}.log
#		python /root/c0r3/09-cms/D-TECT/d-tect.py
		python /root/c0r3/09-cms/WPSeku/wpseku.py -t $all_domain 2>&1 | tee -a all_${all_domain}.log
		nikto -host http://$all_domain 2>&1 | tee -a all_${all_domain}.log
		php rev3r531p.php 2>&1 | tee -a reverse_${all_domain}.log && echo -e "${all_domain}\n"
		echo -e "\n${yell}Logfile is saved as all_${all_domain}.log${clear}\n"
                scanner=Allscan_${all_domain}
                scanlog=all_${all_domain}.log
                sh_mail
		else
		nikto -host http://$all_domain 2>&1 | tee -a all_${all_domain}.log
                php rev3r531p.php 2>&1 | tee -a reverse_${all_domain}.log && echo -e "${all_domain}\n"
		ruby /root/c0r3/09-cms/joomlavs/joomlavs.rb -u $all_domain --scan-all 2>&1 | tee -a all_${all_domain}.log
                echo -e "\n${yell}Logfile is saved as all_${all_domain}.log${clear}\n"
                scanner=Allscan_${all_domain}
                scanlog=all_${all_domain}.log
                sh_mail
		fi
                else
                echo -e "\nPlease enter a domain!\n"
                fi
                ;;


	x)
		break
		;;
        *)

		echo $"Usage: $0 {1-7|a|x}"
		exit 1
	esac
done