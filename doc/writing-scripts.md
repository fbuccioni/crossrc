Writing Scripts
===============

#### Contents
[The Init RC file](#initrc)  
[Configuration file](#config)  
[Post-Install scripts](#postinstall)  

<a name="initrc" />
#The Init RC file

The Init RC file is the main serivce script. This file should be named
`initrc` in your project source folder (i.e. `src/project/initrc`).
    
The idea is the simpliest way to write a service script using a bourne shell
syntax, and basically we use only the `start` and `stop` functions, leaving
`restart` calling `stop` following `start`. Here is an little example

    name="myservice"
    
    some_func_to_check_config() { ... }
    
    start() {
        some_func_to_check_config
        cbegin "starting ${name}"
        myservice --start # The service
        cend $?           # The return status from previous command
    }
    
    stop() {
        cbegin "stopping ${name}"
        myservice --stop # The service
        cend $?          # The return status from previous command
    }
    

In the script can notice, the `cend` and `cbegin` functions, this functions
are built-in in CrossRC to manipulate output and service info. This
functinos later will be translated to the native functions of the target
plataform initrc systen.

If you want to add more arguments you need to set `$extra_args` variable
and create a functino with the name of the arg.

    extra_args="status checkconf"
    
    status() { ... }
    checkconf() { ... }
    
    start() {
    ...


| Function | args   | Description                                   |
|----------|--------|------------------------------------------------------|
| cbegin   | msg    | The service related message (Starting service)       |
| cminfo   | msg... | Prints a information message                         |
| cwarn    | msg... | Prints a warning message                             |
| cerror   | msg... | Prints a error message                               |
| cend     | status | If $status is 0 print OK/done and if $status is 1 print error/fail and return $status

This functinos are based on gentoo init system

<a name="config" />
#Config File

The config file almost always is just a few variables to conf the service,
and should be named `config` in your project source folder (i.e. 
`src/project/config`).

The config file will be sourced at the top of the script, and his path 
or name depends on the platforms configuration.

<a name="postinstall"/>
#Post-Install scripts

To empower the install you can use post-install scripts
here are some information of how to create one and some
examples to give some ideas.

You can create post-install files per-platform i.e

     src/project/include/linux.gentoo/post-install.sh
    
And just for all
    
     src/project/include/post-install.sh

The two types of post-install executes separetly, first the platform post-install and the include post-install after. 

You can use any variable from de crossrc environment inside the scripts


Examples of post install commands
---------------------------------

- Create a service-only user

        useradd -r -d /nonexistant -U -s /bin/true user

- Create a log folder in /var/log

         install -d -g use -o group -m 755 /var/log/fstream
                     