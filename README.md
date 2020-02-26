
![](https://img.shields.io/docker/pulls/papko26/kaniko_envsubst.svg)
![](https://img.shields.io/docker/cloud/build/papko26/kaniko_envsubst.svg)
# kaniko_envsubst
docker pull papko26/kaniko_envsubst

### TLDR:
[GoogleContainerTools/kaniko](https://github.com/GoogleContainerTools/kaniko) + [a8m/envsubst](https://github.com/a8m/envsubst) image for gitlab runner on kubernetes.

### Why?
Because you may want to use kaniko to build your images in kubernetes, and envsubst to dynamically replace variables in dockerfile from ENV

### How?
`.gitlab-ci.yml`
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
