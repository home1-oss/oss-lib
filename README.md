[![Build Status](https://travis-ci.org/home1-oss/oss-lib.svg?branch=master)](https://travis-ci.org/home1-oss/oss-lib)

-----
There are link issues on git service generated pages, see gitbook or maven site.
+ [gitbook](https://home1-oss.github.io/home1-oss-gitbook/release/docs/oss-lib/)
+ [maven site](https://home1-oss.github.io/home1-oss/release/oss-lib/index.html)
-----

# oss-lib
Libraries of home1-oss (home1 open source stack)

Custom and extend open source software libraries for better user experience.

## Libraries of home1-oss:
+ [oss-lib-adminclient](./oss-lib-adminclient/) Enhanced `spring-boot-admin` client.
+ [oss-lib-common](./oss-lib-common/) Common library used by all home1-oss libraries, including extended spring-boot config and crypto utils.
+ [oss-lib-errorhandle](./oss-lib-errorhandle/) Error handle library with Feign RPC and swagger support.
+ [oss-lib-log4j2](./oss-lib-log4j2/) JMX extension for log4j2 and `spring-boot-admin`.
+ [oss-lib-security](./oss-lib-security/) Simplified and stateless security library based on `spring-security` with swagger support.
+ [oss-lib-swagger](./oss-lib-swagger/) Switch `swagger` API doc on/off by environment, provide default API group.
+ [oss-lib-test](./oss-lib-test/) Test utils.
+ [oss-lib-webmvc](./oss-lib-webmvc/) Provide custom config and utils for `spring-webmvc`.

## Why not just open a PR

It is best to push new features or bug fixes to the original author, 
but sometimes because open source software design and our own goals are not the same, 
or limited by the author's design or view, They will not merge our pull / merge request.

We need to extend or modify them by ourselves and try our best to avoid coping and modifying source code.
