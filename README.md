# Run NFT locally from a Singularity container

## Get the Docker files

```
./pull_dockerfiles.sh
```

## Get the Singularity containers

```
./create_singularity_containers.sh
```


## Troubleshooting

## Backend

### Could not resolve placeholder ${TOWER_SMTP_USER}

```
$ ./nf-tower_backend-latest.sif 
OpenJDK 64-Bit Server VM warning: Unable to open cgroup memory limit file /sys/fs/cgroup/memory/memory.limit_in_bytes (No such file or directory)
06:35:17.186 [main] INFO  io.seqera.tower.Application - ++ Tower backend starting ++ System: Linux 6.2.0-26-generic; Runtime: Groovy 2.5.8 on OpenJDK 64-Bit Server VM 1.8.0_252-b09; Encoding: ANSI_X3.4-1968 (ANSI_X3.4-1968); 
06:35:17.298 [main] WARN  i.m.context.env.DefaultEnvironment - Unable to load properties file: tower
06:35:17.780 [main] INFO  i.m.c.h.g.HibernateDatastoreFactory - Starting GORM for Hibernate
06:35:18.848 [main] INFO  org.hibernate.Version - HHH000412: Hibernate Core {5.4.10.Final}
06:35:18.936 [main] INFO  o.h.validator.internal.util.Version - HV000001: Hibernate Validator 6.0.18.Final
06:35:18.948 [main] INFO  o.h.v.i.engine.ConfigurationImpl - HV000002: Ignoring XML configuration.
06:35:19.040 [main] INFO  o.h.annotations.common.Version - HCANN000001: Hibernate Commons Annotations {5.1.0.Final}
06:35:19.109 [main] INFO  org.hibernate.dialect.Dialect - HHH000400: Using dialect: org.hibernate.dialect.H2Dialect
06:35:20.392 [main] INFO  o.h.v.i.engine.ConfigurationImpl - HV000002: Ignoring XML configuration.
06:35:20.949 [main] ERROR io.micronaut.runtime.Micronaut - Error starting Micronaut server: Error instantiating bean of type  [io.seqera.tower.service.mail.MailServiceImpl]

Message: Could not resolve placeholder ${TOWER_SMTP_USER}
Path Taken: ApplicationListener.setDispatcher([ApplicationEventDispatcher dispatcher]) --> ApplicationEventDispatcherImpl.setEventPublisher([AuditEventPublisher eventPublisher]) --> AuditEventPublisher.setMailService([MailService mailService]) --> MailServiceImpl.setConfig([MailerConfig config])
io.micronaut.context.exceptions.BeanInstantiationException: Error instantiating bean of type  [io.seqera.tower.service.mail.MailServiceImpl]

Message: Could not resolve placeholder ${TOWER_SMTP_USER}
Path Taken: ApplicationListener.setDispatcher([ApplicationEventDispatcher dispatcher]) --> ApplicationEventDispatcherImpl.setEventPublisher([AuditEventPublisher eventPublisher]) --> AuditEventPublisher.setMailService([MailService mailService]) --> MailServiceImpl.setConfig([MailerConfig config])
	at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1719)
	[...]
	at io.seqera.tower.Application.main(Application.groovy:40)
Caused by: io.micronaut.context.exceptions.ConfigurationException: Could not resolve placeholder ${TOWER_SMTP_USER}
	at io.micronaut.context.env.DefaultPropertyPlaceholderResolver$PlaceholderSegment.getValue(DefaultPropertyPlaceholderResolver.java:283)
	[...]
	at io.micronaut.context.DefaultBeanContext.doCreateBean(DefaultBeanContext.java:1693)
	... 52 common frames omitted
```

From [here](https://github.com/seqeralabs/nf-tower/tree/master#backend-settings):

```
Tower backend settings can be provided in either:

    application.yml in the backend class-path
    tower.yml in the launching directory

A minimal config requires the settings for the SMTP server, using the following variables:

    TOWER_SMTP_HOST: The SMTP server host name e.g. email-smtp.eu-west-1.amazonaws.com.
    TOWER_SMTP_PORT: The SMTP server port number e.g. 587.
    TOWER_SMTP_USER: The SMTP user name.
    TOWER_SMTP_PASSWORD: The SMTP user password.

```

Solution: create a file called `tower.yml` with this example content:

```
TOWER_SMTP_HOST: localhost
TOWER_SMTP_PORT: 587
TOWER_SMTP_USER: richel
TOWER_SMTP_PASSWORD: iloverichel
```

And download the file `application.yml`:

```
download_application_yml.sh
```


## Frontend

### nginx: [emerg] host not found in upstream "backend:8080"

```
$ ./nf-tower_web-latest.sif 
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: can not modify /etc/nginx/conf.d/default.conf (read-only file system?)
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2023/08/16 08:34:08 [emerg] 7252#7252: host not found in upstream "backend:8080" in /etc/nginx/nginx.conf:10
nginx: [emerg] host not found in upstream "backend:8080" in /etc/nginx/nginx.conf:10
```

 * Hypothesis: this is because the backend is not running.
   * To find this out: `./is_backend_running.sh`
     * If the backend is not running, do `./nf-tower_backend-latest.sif`
 * Hypothesis: the SSH server `upstream` must be defined, from [here](https://github.com/seqeralabs/nf-tower/blob/6e483c48633106f0e157278a94ee74710abe0353/COMPONENTS.md?plain=1#L15):

```
## Proxy 

  http://localhost:8000:/api/* -> http://backend:8080/*  

Config: 
  - tower-web/nginx.conf       [prod]
  - tower-web/proxy.conf.json  [dev]
```

Solution:

```
./download_nginx_conf.sh
./download_proxy_config_json.sh
sudo apt-get install nginx
```



```
??
ssh -L 8080:backend:8000
```
