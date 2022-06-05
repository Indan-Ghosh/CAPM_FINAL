git add .
echo -n "what is this change for?"
read;
git commit -m "${REPLY}"
git push