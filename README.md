# kaniko_envsubst
docker pull papko26/kaniko_envsubst

### TLDR:
GoogleContainerTools/kaniko + a8m/envsubst dockerfile

### Why?
Because you may want to use kaniko to build your images in kubernetes, and envsubst to dynamically replace variables in dockerfile from ENV

### How?
```yaml
build_image:
  stage: build
  image:
    name: papko26/kaniko_envsubst
    entrypoint: [""]
  script:
    - cat $CI_PROJECT_NAME.Dockerfile | envsubst > $CI_PROJECT_NAME.busted.Dockerfile
    - echo "{\"auths\":{\"$CI_REGISTRY\":{\"username\":\"$CI_REGISTRY_USER\",\"password\":\"$CI_REGISTRY_PASSWORD\"}}}" > /kaniko/.docker/config.json
    - /kaniko/executor -c . -f $CI_PROJECT_NAME.busted.Dockerfile -d $CI_REGISTRY_IMAGE/base:$CI_COMMIT_TAG -d $CI_REGISTRY_IMAGE/base:latest
```
