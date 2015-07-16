### Docker Installation

To install, download and install [Docker](https://docker.com/) for your platform.

Once Docker is installed, you can run a downloadable image from Docker Hub, or build your own.
To download and use the Docker Hub image, you can run:

```bash
$ CID=$(docker run -d nicopace/ionic-cordova-android-vagrant-) # This runs the Docker Image

$ # And this gets you inside the Docker Image so you can use it
$ IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress  }}' $CID)
$ ssh app@$IP # password: app
```

If you prefer to build your own image, download the latest release of this GitHub repo, and unzip it. `cd` into the unzipped folder and run:

```bash
$ docker build --tag="username/ionicbox" --no-cache=false .
```

Then, you can run your own image, running the command specified before, changing the tag (in that case nicopace/ionic-cordova-android-vagrant-) with your own (in this case, username/ionicbox)
