FROM alpine

CMD echo "Updating DNS ${SUBDOMAIN}.freemyip.com" \
    && nslookup ${SUBDOMAIN}.freemyip.com \
    && wget -q -O - https://freemyip.com/update?token=${TOKEN}&domain=${SUBDOMAIN}.freemyip.com \
    && sleep 5 \
    && wget -q -O - https://freemyip.com/update?token=${TOKEN}&domain=${SUBDOMAIN}.freemyip.com \
    && sleep 5 \
    && nslookup ${SUBDOMAIN}.freemyip.com \
    && echo "Updated DNS ${SUBDOMAIN}.freemyip.com "