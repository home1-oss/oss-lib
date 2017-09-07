
# oss-lib-common
Common utils and components for open source stack libraries

Common library used by all home1-oss libraries, including extended spring-boot config and crypto utils.


## Extended spring-boot config

- Custom properties in `AppProperties` class.

- Annotations to control bean initializing.
  + `@ConditionalOnAppType` - `app.type`
  + `@ConditionalOnAppSecurity` - `app.security.enabled`
  + `@ConditionalOnNotEnvProduction` - `spring.profile.active`


## Crypto utils

+ AES
+ RSA
+ JWT

Simplifies the use of complex crypto libraries, 
initialize encryptors / decryptors when spring-boot application is automatically configured.


## Template interpolate

Based on EL expression.


## Other utils

See javadoc or source code.
