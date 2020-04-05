# 🚀 Docker ECR for GitHub Actions

[GitHub Action](https://developer.github.com/actions/) for uploading Docker Image to Amazon Elastic Container Registry (ECR).

![Docker ECR](https://github.com/appleboy/docker-ecr-action/workflows/Docker%20ECR/badge.svg?branch=master&event=push)

![Amazon ECR](./images/Amazon_ECR.png)

## What is ECR

Amazon Elastic Container Registry (ECR) is a fully-managed Docker container registry that makes it easy for developers to store, manage, and deploy Docker container images. Amazon ECR is integrated with Amazon Elastic Container Service (ECS), simplifying your development to production workflow. Amazon ECR eliminates the need to operate your own container repositories or worry about scaling the underlying infrastructure. Amazon ECR hosts your images in a highly available and scalable architecture, allowing you to reliably deploy containers for your applications. Integration with AWS Identity and Access Management (IAM) provides resource-level control of each repository. With Amazon ECR, there are no upfront fees or commitments. You pay only for the amount of data you store in your repositories and data transferred to the Internet. See the more [detail information](https://aws.amazon.com/ecr/).

## Usage

Upload docker image to Amazon Elastic Container Registry (ECR)

```yml
- name: upload image to ECR
  uses: ./
  with:
    access_key: ${{ secrets.aws_access_key_id }}
    secret_key: ${{ secrets.aws_secret_access_key }}
    registry: ${{ secrets.registry }}
    cache_from: ${{ secrets.cache }}
    repo: api-sample
    region: ap-northeast-1
    auto_tag: true
    daemon_off: false
    dockerfile: example/Dockerfile
    context: example
```

## Input variables

* access_key - amazon access key
* secret_key - amazon secret access key
* region - amazon region, defaults to us-east-1
* repo - repository name for the image
* lifecycle_policy - filename of ecr lifecycle json policy
* repository_policy - filename of ecr repository json policy
* tags - repository tag for the image, defaults to latest
* dockerfile - dockerfile to be used, defaults to Dockerfile
* auth - auth token for the registry
* context - the context path to use, defaults to root of the git repo
* force_tag - replace existing matched image tags
* insecure - enable insecure communication to this registry
* mirror - use a mirror registry instead of pulling images directly from the central Hub
* bip - use for pass bridge ip
* custom_dns - set custom dns servers for the container
* storage_driver - supports aufs, overlay or vfs drivers
* build_args - custom arguments passed to docker build
* cache_from - images to consider as cache sources
* auto_tag: default build tags
* daemon_off: don't start the docker daemon

## Example

The ECR plugin can be used to build and publish images to the Amazon ECR registry. The below pipeline configuration demonstrates simple usage:

```yaml
- name: upload image to ECR
  uses: appleboy/drone-ecr
  with:
    access_key: a50d28f4dd477bc184fbd10b376de753
    secret_key: bc5785d3ece6a9cdefa42eb99b58986f9095ff1c
    repo: bar
    registry: <account_id>.dkr.ecr.us-east-1.amazonaws.com
```

Example configuration using multiple tags:

```yaml
- name: upload image to ECR
  uses: appleboy/drone-ecr
  with:
    repo: bar
    registry: <account_id>.dkr.ecr.us-east-1.amazonaws.com
    tags: "latest,1.0.1,1.0"
```

Override the default region:

```yaml
- name: upload image to ECR
  uses: appleboy/drone-ecr
  with:
    repo: bar
    registry: <account_id>.dkr.ecr.us-east-1.amazonaws.com
    region: us-east-1
```

Override the default Dockerfile path:

```yaml
- name: upload image to ECR
  uses: appleboy/drone-ecr
  with:
    repo: bar
    registry: <account_id>.dkr.ecr.us-east-1.amazonaws.com
    dockerfile: path/to/Dockerfile
```

Example configuration using build arguments:

```yaml
- name: upload image to ECR
  uses: appleboy/drone-ecr
  with:
    repo: bar
    registry: <account_id>.dkr.ecr.us-east-1.amazonaws.com
    build_args: "HTTP_PROXY=http://yourproxy.com"
```
