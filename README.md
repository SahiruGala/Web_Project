# Web_Project
docker-aws project

# author
Sahiru Galappaththi

# git clone the project resource files from the following link
https://github.com/SahiruGala/Web_Project

# move into Web_Project directory and change permissions.
chmod 775 *

# Build the docker Image
docker build -t webproject .

# Run the docker Image while changing the port number in order to get multiple web servers 
docker run -it --rm -d -p 8080:80 --name website webproject
docker run -it --rm -d -p 8081:80 --name website2 webproject
docker run -it --rm -d -p 8082:80 --name website3 webproject

# to stop a running servers
sudo docker website

# read Documentation for full aws walkthrough
