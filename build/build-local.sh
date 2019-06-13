#!/bin/bash

module=bigtable-autoscaler

set -e

if ! docker ps 1>/dev/null; then
    echo "no docker"
    exit 1
fi

version=$(mvn -q \
    -Dexec.executable=echo \
    -Dexec.args='${project.version}' \
    --non-recursive \
    exec:exec
)
echo "using version:$version"

if [[ $version == *"SNAPSHOT" ]]; then
    echo "Do not use name that conflicts with production container names!"
    exit 1
fi

mvn clean package -DskipTests
#wget -O dd-java-agent.jar 'https://search.maven.org/classic/remote_content?g=com.datadoghq&a=dd-java-agent&v=LATEST'
docker build . -t $module:latest --build-arg VERSION=$version
docker tag $module:latest $module:$version
docker tag $module:latest gcr.io/dauntless-141219/$module:$version

echo "to upload, run ----"
echo "docker push gcr.io/dauntless-141219/$module:$version"
echo "----"
