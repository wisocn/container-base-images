#!/usr/bin/env bash
set -euo pipefail

echo "Users are set up"
grep "appuser:x:1001:1001" /etc/passwd
grep "appuser:x:1001" /etc/group

# installations
echo "bash is $(which bash)"
echo "curl is $(which curl) $(which curl && curl --version)"
echo "dig is $(which dig)"

echo "less is $(which less)"
echo "java is $(which java) $(which java && java -version)"
echo "netstat is $(which netstat) $(which netstat && netstat --version)"
echo "ps is $(which ps)"
echo "top is $(which top)"
echo "htop is $(which htop)"
echo "xmllint is $(which xmllint)"
echo "jattach is $(which jattach)"
echo "Who am I? $(whoami)"

#Home directory is correctly created
ls /app
ls /app/logs
