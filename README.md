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


