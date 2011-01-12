# Add a command to add tweet to delicious for storage or later
# viewing from GUI browser
#

use URI::Escape;

$addaction = sub {
	my $command = shift;

  	if ($command =~ m#^/later ([^ ]+) ?#) {
		my $tweet_id=$1;
		my $tweet=&get_tweet($tweet_id);
		if (!$tweet->{'id_str'}) {
		    print $stdout "-- sorry, no such tweet (yet?).\n";
		    return 1;
		}
        
		chop( my $instapaper_user=`cat ~/.instapaper`);
		my $add_url=uri_escape("http://twitter.com/$tweet->{'user'}->{'screen_name'}/statuses/$tweet->{'id_str'}");
       
		my $instapaper_url="https://www.instapaper.com/api/add?username=$instapaper_user&url=" .  $add_url;
		my $content = `curl -s \"$instapaper_url\"`;
        
		if ($content =~ m!201!){
		}else{ 
			print "Something went wrong, not added. Response: $content";
		}
		return 1;
	}
	return 0;
};
