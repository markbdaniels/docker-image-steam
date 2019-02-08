# docker-image-steam
Example Dockerfile which creates a docker container instance running [image-steam](https://www.npmjs.com/package/image-steam)

### Installation
Create a isteam config file 
This example configures AWS S3 as a store and cache:
```json
{
  "http": [
    {
      "host": "0.0.0.0",
      "port":13337
    }
  ],
  "storage": {
    "app": {
      "bike": {
        "driverPath": "image-steam-s3",
        "endpoint": "s3.amazonaws.com",
        "bucket": "YOUR_BUCKET",
        "accessKey": "YOUR_ACCESS_KEY",
        "secretKey": "YOUR_SECRET_KEY"
      }
    },
    "cache": {
      "driverPath": "image-steam-s3",
      "bucket": "YOUR_BUCKET",
      "accessKey": "YOUR_ACCESS_KEY",
      "secretKey": "YOUR_SECRET_KEY"
    }
  }
}
```

Create the docker image:
```sh
$ docker build --tag=test-image-steam . --build-arg isteam_config=config-docker.json
```

Launch container:
```sh
$ docker run -p 13337:13337 test-image-steam
```

Test
```http
http://localhost:13337/bike/thepic.jpg/:/rs=w:640/cr=l:5%25,t:10%25,w:90%25,h:80%25/fx-gs
```
