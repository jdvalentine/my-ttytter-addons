test-fsearch: 
	echo "/fsearch reuteras" | ./bin/ttytter -exts=friend_search_oauth.pl -ssl -simplestart | grep "Screen name: reuteras. Name: Peter Reuterås"
