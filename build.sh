version="0.2"
docker build -t ducker:$version .
docker tag ducker:$version sinnerr/ducker:$version
docker tag ducker:$version sinnerr/ducker:latest
docker push sinnerr/ducker:$version
docker push sinnerr/ducker:latest
