MediaWiki_SB
============
Mission 4 MediaWiki with GitHub

HOW TO USE
-----------
1.	Make sure Git Shell and Vagrant are installed on your host system.
2.	Open "Git Shell" and go to a directory you use for Vagrant experiments.
3.	Get this code from Github. This will make a new folder with the name MediaWiki_SB: 
		git clone https://github.com/SteveBerneel/MediaWiki_SB.git

4.  Go to Git Shell and type $  vagrant up

5.  Finish MediaWiki installation
		•	Go to http://192.168.56.65/mediawiki 
	Databasehost: localhost   DatabaseName: mediawiki
	Username for database: root      Pass:  thi1313
	User is same as for database access
	Name Page: 
Wiki Name: (Your Wiki name)
ProjectNameSpace: Same as WikiName
Your Name: (YourName)       Pass: thi1313        Mail: (YourMailAddress)

6.	Copy LocalSettings.php file to the wiki installation folder:
	Log in via FileZilla (or other ftp client ) on host with user vagrant & pass vagrant
	Place the LocalSettings.php file that you got at the end of the wiki web config procedure
	in the homefolder of the vagrant user with ftp client. 
	
7.	In Git Shell type : vagrant ssh      and then type :
	sudo cp LocalSettings.php /var/www/html/mediawiki ( to copy the file to the mediawiki folder )

8.	First Wiki is done.


For info mail to:    steve@berneel.be
