# Add a command to add tweet to delicious for storage or later
# viewing from GUI browser
#

$addaction = sub {
	my $command = shift;

	if ($command =~ m#^/later (.+) (.+)#) {
		my $tweet_id=$1;
		my $desc=$2;
		my $tweet = &get_tweet($tweet_id);
		if (!$tweet->{'id'}) {
			print $stdout "-- sorry, no such tweet (yet?).\n";
			return 1;
		}
		chop( my $del_pass=`cat ~/.delicious`);
		my $add_url="http://twitter.com/$tweet->{'user'}->{'screen_name'}/statuses/$tweet->{'id'}";
		my $del_url="https://api.del.icio.us/v1/posts/add?url=" .
			$add_url . "&tags=\@ttytter_added\@&shared=no&description=$desc";
		my $content = `curl -s -u \"$del_pass\" \"$del_url\"`;
		if ($content =~ m!<result code="done" />!){
			print "Added to delicious.com\n";
		}else{
			print "Something went wrong, not added. Se response:\n";
			print $content;	
		}
		return 1;
	}

	return 0;
};

