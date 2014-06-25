CrossRC
=======

CrossRC is a simple cross-platform service script framework, created to
build portable daemon system scripts in different platforms.


Getting Started
---------------

To create a project you have to use a common folder structure:

    /                      Project Root
      build/               CrossRC directory
      src/                 Sources directory
        PROJECT_NAME/      Your project(s) name
          initrc           Service init rc fie
          conf             Service init rc config file
            include        See "Replacing common includes" Section
            os             Platform configuration overrides
        ANOTHER_PROJECT/   ...
          ...

To start from zero use the following commands in your project root folder

    $ git submodule add http://github.com/falcacibar/crossrc.git build
    $ ./build/project PROJECT_NAME
    
The main script `crossrc`
-------------------------

This script are the heart of crossrc, this script do all the work 
reading all the projects in `src/` and applying the command to the
project. The following commands are permitted:

| Command   | Description
|-----------|-----------------------------------------------
| `build`   | Build the scripts and put it in `$distdir`
| `install` | Installs script in the system (If it is configured)
| `clean`   | Cleans build paths


You can use multiple commands, for example, for `build`, `install`
and `clean` use the following command

    $ ./build/crossrc build install clean

NOTE: Maybe you need a superuser permissions to install

Writing scripts with CrossRC
---------------------------

##### Code Guidelines
[Writing Scripts](doc/writing-scripts.md)  
[Variables](doc/variables.md)  

##### In the deep
[Replacing Common Includes](doc/replacing-common-includes.md)  
[Platform Configuration](doc/platform-conf.md)  



Credts
-------

- Thanks to my friend Christopher Castro who let me experiment with his infrastructure


-----------------------------------------------------------------------
All your feedback is welcome, have a nice day.


