#!/bin/sh

# TODO: add preflight check (minimum requirements)

SITE_LIST="www.kismetwireless.net macupdate.com github.com google.com svn.nmap.org news.ycombinator.com www.ripe.net login.yahoo.com bitbucket.org filippo.io"
FILTER=1
ENVIRON="no-filter"
[ $FILTER -gt 0 ] && ENVIRON="filter"

printf "Running tests in parallel "

for SITE in $SITE_LIST
do
#	openssl s_client -ssl3 -connect "${SITE}:443" < /dev/null > ${ENVIRON}-ssl3-connect-${SITE}.log 2>&1 && printf "." &
	openssl s_client -tls1 -connect "${SITE}:443" < /dev/null > ${ENVIRON}-tls1-connect-${SITE}.log 2>&1 && printf "." &
#	curl -3 -o /dev/null -s --trace "${ENVIRON}-ssl3-trace-${SITE}.log" https://${SITE} && printf "." &
	curl --tlsv1.0 -o /dev/null -s --trace "${ENVIRON}-tlsv1.0-trace-${SITE}.log" https://${SITE} && printf "." &
	curl --tlsv1.1 -o /dev/null -s --trace "${ENVIRON}-tlsv1.1-trace-${SITE}.log" https://${SITE} && printf "." &
	curl --tlsv1.2 -o /dev/null -s --trace "${ENVIRON}-tlsv1.2-trace-${SITE}.log" https://${SITE} && printf "." &
done

wait

printf " done\n"
