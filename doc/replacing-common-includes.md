Replacing Common Includes
=========================

Some generic components could be replaced if is necessary.

##### Possible replacements
[Head (head.sh)](#head)  
[CrossRC Functions (funcs.sh)](#funcs)  
[Argument Handler (arg_handler.sh)](#arghandler)  
[Foot (foot.sh)](#foot)  

<a name="head"/>
#Head (head.sh)

The head should have the interpreter first line `#!/bin/sh` and some extra
commands.

The file `head.sh` will be located at the following order:

- `${src_os_inc_dir}/head.sh`
- `${os_inc_dir}/head.sh`
- `${gen_inc_dir}/head.sh`

<a name="funcs"/>
#CrossRC Functinos (funcs.sh)

This are the CrossRC framework functions `cinfo`, `cwarn`, `cerror`,
`cbegin` and `cend`.

The file `funcs.sh` will be located at the following order:

- `${src_os_inc_dir}/funcs.sh`
- `${src_inc_dir}/funcs.sh`
- `${os_inc_dir}/funcs.sh` 

<a name="foot"/>
#Foot (foot.sh)

This code will be just following the `initrc` include.

The file `foot.sh` will be located at the following order:

- `${src_os_inc_dir}/foot.sh`
- `${os_inc_dir}/foot.sh`
- `${gen_inc_dir}/foot.sh` 

<a name="arghandler"/>
#Argument Handler (arg_handler.sh)

The argument handler is the part of the script that handles the arguments. The generic arg handler, supports `start`, `stop` and `restart` primarily but you can add extra arguments with `$extra_args` variable.

Some platforms does not use an argument handler, like `linux.gentoo` and
this is configurable in the `$generic_arg_handler` conf variable. But in the
case that you want another way to handle arguments you can overwrite it
always when `$generic_arg_handler` is `no`.

The file `arg_handler.sh` will be located at the following order:

- `${src_os_inc_dir}/arg_handler.sh`
- `${src_inc_dir}/arg_handler.sh`