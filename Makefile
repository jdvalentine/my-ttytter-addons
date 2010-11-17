test-fsearch: 
	echo "/fsearch reuteras" | ./bin/ttytter -exts=friend_search_oauth.pl -ssl -simplestart | grep "Screen name: reuteras. Name: Peter Reuterås"
test-rate:
	echo "/limit" | ./bin/ttytter -exts=rate_limit_oauth.pl -ssl -simplestart | egrep "Remaining hits [0-9]{3}"

