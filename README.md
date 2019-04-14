# WP.org Plugin Deploy

Deploy plugin updates to WordPress.org's plugin SVN. Modeled on [10up's GitHub action](https://github.com/10up/actions-wordpress/blob/598b1572d5024340f09d7efc083a65ebff3bcdef/dotorg-plugin-deploy/entrypoint.sh) of the same intent.

## Configuration

### `.gitlab-ci.yml`

Add the following to the plugin's `.gitlab-ci.yml`:

```yaml
PluginSVN:
  stage: deploy
  image: containers.ethitter.com:443/docker/images/php:7.3
  before_script:
    - apt-get update
    - apt-get install -y rsync
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

* `WP_ORG_PASSWORD`
* `WP_ORG_PASSWORD`
* `PLUGIN_SLUG` - plugin's name on WordPress.org
* `PLUGIN_VERSION` - version to tag
* `WP_ORG_RELEASE_REF` - commit ref (branch or tag) to use for release 
