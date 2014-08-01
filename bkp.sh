#!/bin/sh
#
# crontab rule
# crontab -e
#0 1 * * 1-5 /home/path/scripts/bkp.sh > /dev/null 2>&1


echo "folder 1"
until ./sshpass -p 'passwd' rsync -avz -e ssh account@address:./folder_1 /home/path/bkp; do
  echo Tansfer disrupted, retrying in 10 seconds...
  sleep 65
done
echo "folder 1" success $(date) >> /home/path/bkp/success.txt

echo "folder 2"
until ./sshpass -p 'passwd' rsync -avz -e  ssh account@address:./folder_2 /home/path/bkp; do
  echo Tansfer disrupted, retrying in 10 seconds...
  sleep 65
done
echo "folder 2" success $(date) >> /home/path/bkp/success.txt

# 7 day rotation
rm -r /home/path/bkp_rotation/8 &&
mv /home/path/bkp_rotation/7 /home/path/bkp_rotation/8 &&
mv /home/path/bkp_rotation/6 /home/path/bkp_rotation/7 &&
mv /home/path/bkp_rotation/5 /home/path/bkp_rotation/6 &&
mv /home/path/bkp_rotation/4 /home/path/bkp_rotation/5 &&
mv /home/path/bkp_rotation/3 /home/path/bkp_rotation/4 &&
mv /home/path/bkp_rotation/2 /home/path/bkp_rotation/3 &&
mv /home/path/bkp_rotation/1 /home/path/bkp_rotation/2 &&
mkdir -p /home/path/bkp_rotation/1
cp -r /home/path/bkp /home/path/bkp_rotation/1

exit 0