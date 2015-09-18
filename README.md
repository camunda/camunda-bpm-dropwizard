# camunda-bpm-dropwizard

The power of camunda and REST in a single jar.


## Get started

_A quick description how your project can be used, including where the relevant resources can be obtained from.
Put into another file if too big._

### Noteworthy

* Dropwizard does not support Java6, so despite the camunda standard compiler settings, this has do be done with targetJDK=1.7

## Repository structure

We need to separate the extension (production) code from the examples, so we do not accidentally use some parent 
pom/dependency management features in the example code. Instead of providing separate repositories, we will use a split repo
 layout:
 
 ```
 camunda-bpm-dropwizard-root # just a common parent pom, defines properties but nothing else
 |- extension                # the actual implementation
 ||- camunda-bpm-dropwizard-core # starting engine, jetty and rest
 |- examples                 # home of the examples
 ||- process-invoice         # the camunda invoice example on dropwizard
 ||- process-twitter         # the camunda twitter example on dropwizard
 ```

## Resources

* [Issue Tracker](link-to-issue-tracker) _use github unless you got your own_
* [Roadmap](link-to-issue-tracker-filter) _if in terms of tagged issues_
* [Changelog](link-to-changelog) _lets users track progress on what has been happening_
* [Download](link-to-downloadable-archive) _if downloadable_
* [Contributing](link-to-contribute-guide) _if desired, best to put it into a CONTRIBUTE.md file_


## Roadmap

_specify a short list of things that yet need to be done (unless you organize it elsewhere)_

**todo**
- add feature B
- integrate with technology X

**done**
- add feature A

## Useful resources

### How to import the REST classes (instead the war file)

```xml
<dependency> 
  <groupId>org.camunda.bpm</groupId> 
  <artifactId>camunda-engine-rest</artifactId> 
  <classifier>classes</classifier> 
  <version>7.1.0-Final</version> 
</dependency> 
```

### example with spring

* [embedded-spring-rest](https://github.com/camunda/camunda-bpm-examples/tree/master/deployment/embedded-spring-rest)
* http://docs.camunda.org/latest/guides/user-guide/#process-engine-process-engine-bootstrapping

## Maintainer

* [Jan Galinski](https://github.com/jangalinski), [Holisticon AG](http://www.holisticon.de/)

## License

* [Apache License, Version 2.0](./LICENSE)
