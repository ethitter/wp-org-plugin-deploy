# WP.org Plugin Deploy [![pipeline status](https://git.ethitter.com/open-source/wp-org-plugin-deploy/badges/master/pipeline.svg)](https://git.ethitter.com/open-source/wp-org-plugin-deploy/commits/master)

Deploy plugin updates to WordPress.org's plugin SVN. Modeled on [10up's GitHub action](https://github.com/10up/actions-wordpress/blob/598b1572d5024340f09d7efc083a65ebff3bcdef/dotorg-plugin-deploy/entrypoint.sh) of the same intent.

## Configuration

1. Add the `.gitlab-ci.yml` configuration described below.
1. Set the environment variables in the GitLab project.

### `.gitlab-ci.yml`

Add the following to the plugin's `.gitlab-ci.yml`:

```yaml
PluginSVN:
  stage: deploy
  image: containers.ethitter.com:443/docker/images/php:7.3
  before_script:
    - curl -o ./bin/deploy.sh https://git-cdn.e15r.co/open-source/wp-org-plugin-deploy/raw/master/scripts/deploy.sh
    - chmod +x ./bin/deploy.sh
  script: ./bin/deploy.sh
  when: on_success
```

While unnecessary, if you'd rather save the time of testing the deploy, append the following to the CI job's configuration:

```yaml
only:
  - master
```

The above is a time-save only; the build script exits before the `svn commit` stage if the merge isn't into `master`. 

### CI Environment Variables

Set the following environment variables in the GitLab project's configuration:

* `WP_ORG_USERNAME`
* `WP_ORG_PASSWORD`
* `PLUGIN_SLUG` - plugin's name on WordPress.org
* `PLUGIN_VERSION` - version to tag
* `WP_ORG_RELEASE_REF` - git commit ref (branch or tag) to use for release 

### Alternatives

A [loader script](./scripts/loader.sh) is available as an alternative to downloading the deploy script during the `before_script` stage.

## Ignoring items

The build script uses a `.gitattributes`-based ignore for reasons discussed at [https://github.com/10up/actions-wordpress/pull/7](https://github.com/10up/actions-wordpress/pull/7).

A sample is provided in [examples/gitattributes](./examples/gitattributes). If used, it needs to be copied to `.gitattributes` in the git-repo root and committed before it will be respected.

```
# A set of files you probably don't want in your WordPress.org distribution
/.gitattributes export-ignore
```

## Protecting deploys

Choose a `WP_ORG_RELEASE_REF` value that starts with a consistent prefix. Doing so allows that prefix to be protected using GitLab's "Protected Branches" or "Protected Tags" features.
