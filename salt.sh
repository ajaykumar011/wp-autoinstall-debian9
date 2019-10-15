#!/bin/bash -e
#set WP salts
	perl -i -pe'
	  BEGIN {
	    @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
	    push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
	    sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
	  }
	  s/put your unique phrase here/salt()/ge
	' wp-config.php

