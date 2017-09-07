> Note: This gradle project if for macos and linux/unix only, windows is not supported

## Why windows is not supported

  Windows has problems on smlinks, see: https://github.com/git-for-windows/git/wiki/Symbolic-Links.

## Import into IDE

  Eclipse use 'buildship-gradle-integration' plugin.

## Local build

  `BUILD_PUBLISH_DEPLOY_SEGREGATION=false ./ci.sh clean test_and_build analysis`

## Deploy into maven repository

  `BUILD_PUBLISH_DEPLOY_SEGREGATION=false ./ci.sh clean test_and_build analysis publish_artifact publish_site`

## References

http://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#boot-features-security-oauth2

https://spring.io/blog/2016/04/15/testing-improvements-in-spring-boot-1-4
[Upgrade to Spring Boot 1.4](https://my.oschina.net/hantsy/blog/720108)

https://spring.io/blog/2015/11/25/migrating-spring-cloud-apps-from-spring-boot-1-2-to-1-3
https://spring.io/blog/2015/11/30/migrating-oauth2-apps-from-spring-boot-1-2-to-1-3
