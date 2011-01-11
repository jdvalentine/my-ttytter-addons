# Add a command to add tweet to delicious for storage or later
# viewing from GUI browser
#

$addaction = sub {
	my $command = shift;

  	if ($command =~ m#^/later ([^ ]+) ([^ ]+)( (.+))?#) {
		my $tweet_id=$1;
		my $desc=$2;
		my $testing=$4;
		my $tweet=&get_tweet($tweet_id);
		if (!$tweet->{'id_str'}) {
		    print $stdout "-- sorry, no such tweet (yet?).\n";
		    return 1;
		}
		chop( my $instapaper_pass=`cat ~/.instapaper`);
		my $add_url="http://twitter.com/$tweet->{'user'}->{'screen_name'}/statuses/$tweet->{'id'}";
		my $instapaper_url="https://www.instapaper.com/api/add?url=" .
			$add_url . "&tags=\@ttytter_added\@&shared=no&description=$desc";
		my $content = `curl -s -u \"$instapaper_pass\" \"$instapaper_url\"`;
        print $instapaper_url;
        print $content;
		if ($content =~ m!<result code="done" />!){
			print "Added to instapaper.com\n";
			if ($testing == "hudson-test"){
				`echo "$add_url" > hudson-ttytter-later-test`;
			}
		}else{ 
			print "Something went wrong, not added. Se response:\n";
			print $content;
		}
		return 1;
	}
	return 0;
};
