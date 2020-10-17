#!/bin/bash

install() {
  echo "
  Instaling security applications.
  "
  sudo apt-get install -qy --install-suggests ufw
  ##### Install software #####
  appsToInstall=(
  clamav clamav-daemon clamscan clamtk clamfs clamdtop
  selinux selinux-utils selinux-basics
  setools setools-gui python-setools
  lsat harden harden-doc tiger policycoreutils cryptsetup
  sepol-utils debsecan rkhunter chkrootkit
  sssd-tools sanitizer sshguard systemsettings
  apparmor apparmor-utils
  )
  for app in "${appsToInstall[@]}"
  do
      sudo apt-get install -qy "$app"
  done
  clear
  }

firewallcheck() {
echo "Firewall check." &&
sudo freshclam
sudo ufw status verbose &&
sleep 3s &&
clear
sudo ufw enable
ufw allow OpenSSH
# Můj port pro ssh je nastaven na:61245
echo "

Firewall port for ssh is set to: 61245

"
ufw allow 61245
ufw allow 8374
ufw allow 31200:31299/tcp
ufw allow 32300:32399/udp
clear
#To check your current settings:
sudo ufw status verbose &&
sleep 3s &&
clear
#Re-check enable (required):
sudo ufw enable
clear
}

chrootkitcheck() {
  echo "Kontrola chrootkitu." &&
  sleep 3s &&
  sudo chkrootkit -q
  sudo rkhunter --update
  sudo rkhunter --propupd
  sudo rkhunter -q --check
  echo "# This file controls the state of SELinux on the system.
  # SELINUX= can take one of these three values:
  # enforcing - SELinux security policy is enforced.
  # permissive - SELinux prints warnings instead of enforcing.
  # disabled - No SELinux policy is loaded.
  SELINUX=enforcing
  # SELINUXTYPE= can take one of these two values:
  # default - equivalent to the old strict and targeted policies
  # mls     - Multi-Level Security (for military and educational use)
  # src     - Custom policy built from source
  SELINUXTYPE=default

  # SETLOCALDEFS= Check local definition changes
  SETLOCALDEFS=0" | sudo tee -a /etc/selinux/config > /dev/null
  sudo bash tiger
  tigercron
  hardening-check
  # sudo gdebi ./Nessus-6.5.3-debian6_amd64.deb
  sudo /etc/init.d/nessusd start
  clear
  }

els() {
    ## Our proceed prompt function
    proceedfunc() {
       echo -n "Proceed? (y/n): "
       read -r PROCEEDASK
       until [ "${PROCEEDASK}" = "y" ] || [ "${PROCEEDASK}" = "n" ]; do
          echo -n "Please enter 'y' or 'n': "
          read -r PROCEEDASK
       done
    }

    ## Install a RKHunter cronjob (to run nightly)
    dorkhuntercron() {
       if [ -e /usr/bin/rkhunter ]; then
          if [ -e /var/lib/rkhunter/tmp ]; then
            sudo rm -rf /var/lib/rkhunter/tmp
          fi
          sudo mkdir /var/lib/rkhunter/tmp
          /usr/bin/rkhunter --update
          echo
          if [ -f /etc/cron.daily/rkhunter.sh ]; then
             rm -rf /etc/cron.daily/rkhunter.sh
          else
              echo '#!/bin/bash'$'\n''(/usr/bin/rkhunter --update && /usr/bin/rkhunter -c --cronjob 2>&1 | mail -s "RKhunter Scan Details"' "${ADMINEMAIL}"')' > /etc/cron.daily/rkhunter.sh
              chmod 700 /etc/cron.daily/rkhunter.sh
          fi
       else
         sudo apt-get install -yfm rkhunter
       fi
    }

    ## Install a CHKROOTKIT cronjob (to run nightly)
    dochkrootkitcron() {
       if [ -e /usr/sbin/chkrootkit ]; then
          echo
          if [ -f /etc/cron.daily/chkrootkit.sh ]; then
             rm -rf /etc/cron.daily/chkrootkit.sh
          else
              echo '#!/bin/bash'$'\n''(/usr/sbin/chkrootkit --update && /usr/sbin/chkrootkit -c --cronjob 2>&1 | mail -s "chkrootkit Scan Details"' "${ADMINEMAIL}"')' > /etc/cron.daily/rkhunter.sh
              chmod 700 /etc/cron.daily/rkhunter.sh
          fi
       else
         sudo apt-get install -yfm chkrootkit
       fi
    }

    ## Chmod dangerous files only to root
    dochmodfiles() {
     if [ -f /usr/bin/rcp ]; then
        chmod 750 /usr/bin/rcp
        echo "Chmoded /usr/bin/rcp to 750."
     fi
     if [ -f /usr/bin/wget ]; then
        chmod 750 /usr/bin/wget
        echo "Chmoded /usr/bin/wget to 750."
     fi
     if [ -f /usr/bin/lynx ]; then
        chmod 750 /usr/bin/lynx
        echo "Chmoded /usr/bin/lynx to 750."
     fi
     if [ -f /usr/bin/links ]; then
        chmod 750 /usr/bin/links
        echo "Chmoded /usr/bin/links to 750."
     fi
     if [ -f /usr/bin/scp ]; then
        chmod 750 /usr/bin/scp
        echo "Chmoded /usr/bin/scp to 750."
     fi
     if [ -d /etc/httpd/proxy ]; then
        chmod 000 /etc/httpd/proxy/
        echo "Chmoded /etc/httpd/proxy/ to 000."
     fi
     if [ -d /var/spool/samba ]; then
        chmod 000 /var/spool/samba/
        echo "Chmoded /var/spool/samba/ to 000."
     fi
     if [ -d /var/mail/vbox ]; then
        chmod 000 /var/mail/vbox/
        echo "Chmoded /var/mail/vbox/ to 000."
     fi
    }

    adminemail
    dorootloginemail
    dorkhuntercron
    dochkrootkitcron
    dochmodfiles
  clear
}

lynis() {
cd /usr/local || exit 1
if [ -d /usr/local/lynis ] || exit 1; then
  rm -rf ./lynis
fi
git clone https://github.com/CISOfy/lynis
cd lynis || exit 1
sudo bash lynis update release
sudo bash lynis audit system -Q
cd ~ || exit 1
clear
  }

install
firewallcheck
chrootkitcheck
els
lynis

exit 0
