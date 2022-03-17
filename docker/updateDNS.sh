
update() {
    wget -q -O - https://freemyip.com/update?token=${TOKEN}&domain=${SUBDOMAIN}.freemyip.com
    sleep 5
    nslookup ${SUBDOMAIN}.freemyip.com
}

echo "Updating DNS ${SUBDOMAIN}.freemyip.com"
for i in $(seq 1 3); do
    echo "----try ${i}----"
    update
done;

echo "Updated DNS ${SUBDOMAIN}.freemyip.com "