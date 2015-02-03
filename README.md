NodeJS 0.10 - Docker image
========================================

This repository contains the sources and
[Dockerfile](https://github.com/jhadvig/sti-nodejs-010/blob/master/Dockerfile)
of the base image for deploying NodeJS applications as reproducible Docker
images. The resulting images can be run either by [Docker](http://docker.io)
or using [STI](https://github.com/openshift/source-to-image). 
User can choose between RHEL7 and CentOS7 base image.

Installation
---------------
*  **RHEL7 base image
This image is not available as trusted build in [Docker Index](https://index.docker.io).

To build a rhel-based nodejs-0.10 image, you need to run docker build it on properly subscribed RHEL machine.

```
$ git clone https://github.com/jhadvig/sti-nodejs-010.git
$ cd sti-nodejs-010
$ make build TARGET=rhel7
```

*  **CentOS7 base image

```
$ git clone https://github.com/jhadvig/sti-nodejs-010.git
$ cd sti-nodejs-010
$ make build TARGET=rhel7
```

Repository organization
------------------------

* **`.sti/bin/`**

  This folder contains scripts that are run by [STI](https://github.com/openshift/source-to-image):

  *   **assemble**

      Is used to restore the build artifacts from the previous built (in case of
      'incremental build'), to install the sources into location from where the
      application will be run and prepare the application for deployment (eg.
      installing modules using npm, etc..)

  *   **run**

      This script is responsible for running the application, by using the
      application web server.

  *   **save-artifacts**

      In order to do an *incremental build* (iow. re-use the build artifacts
      from an already built image in a new image), this script is responsible for
      archiving those. In this image, this script will archive all dependent modules.

* **`nodejs/`**

  This folder contains file with commonly used modules.


Environment variables
---------------------

*  **APP_ROOT** (default: '.')

    This variable specifies a relative location to your application inside the
    application GIT repository. In case your application is located in a
    sub-folder, you can set this variable to a *./myapplication*.

*  **STI_SCRIPTS_URL** (default: '[.sti/bin](https://raw.githubusercontent.com/jhadvig/sti-nodejs-010/master/.sti/bin)')

    This variable specifies the location of directory, where *assemble*, *run* and
    *save-artifacts* scripts are downloaded/copied from. By default the scripts
    in this repository will be used, but users can provide an alternative
    location and run their own scripts.

Usage
---------------------

* **Building the RHEL7 based [nodejs-echo-app](https://github.com/ryanj/node-echo) NodeJS application. Using standalone [STI](https://github.com/openshift/source-to-image) and running the resulting image by [Docker](http://docker.io):**

```
$ sti build https://github.com/ryanj/node-echo.git nodejs-0-rhel7 nodejs-echo-app
$ docker run -p 3000:3000 nodejs-echo-app
```

* **Building the CentOS7 based [nodejs-echo-app](https://github.com/ryanj/node-echo) NodeJS application. Using standalone [STI](https://github.com/openshift/source-to-image) and running the resulting image by [Docker](http://docker.io):**

```
$ sti build https://github.com/ryanj/node-echo.git nodejs-0-centos7 nodejs-echo-app
$ docker run -p 3000:3000 nodejs-echo-app
```

**Accessing the application:**
```
$ curl 127.0.0.1:3000
```