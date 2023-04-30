	# Install Docker
	curl -fsSL https://get.docker.com -o get-docker.sh
	sudo sh get-docker.sh || { echo -e "\e[31mError installing Docker. Exiting.\e[0m"; exit 1; }
	# Install Docker Compose
	sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose




    echo -e "\e[33m Please create the dockeruser account:\e[0m"
    echo -e "\e[33m Enter your Username:\e[0m"
    read username
    echo -e "\e[33m Enter your Password:\e[0m"
    docker_user_password=""
    while IFS= read -r -s -n1 char; do
        if [[ $char == $'\0' ]]; then
            break
        elif [[ $char == $'\177' ]]; then
            if [ -n "$docker_user_password" ]; then
                docker_user_password=${docker_user_password%?}
                echo -ne "\b \b"
            fi
        else
            echo -n "*"
            docker_user_password+="$char"
        fi
    done

    echo
    sudo useradd -m -s /bin/bash $username
    echo $username:$docker_user_password | sudo chpasswd
    sudo usermod -aG docker $username
    sudo usermod -aG sudo $username
	#su - $username
