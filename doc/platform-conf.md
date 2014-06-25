Platform Configuration
======================

The platform configuration is very simple and can be overwritten in a project
the file should have in the `src/project/os/kernel.vendor.sh` (`kernel.vendor` i.e.
`linux.ubuntu`, `bsd.generic`)

| Directive            | Type      | Description
|----------------------|-----------|-------------------------------------------
| $initrcdir           | path      | Path where initrc scripts will be installed
| $initconfdir         | path      | Ṕath where conf will be installed
| $confsuffix          | string    | Suffix of the conf file (i.e. ".conf")
| $source_conf         | yes/no    | Include manually the conf file
| $generic_funcs       | yes/no    | Use generic or platform init funcs
| $gneric_arg_handler  | yes/no    | Use generic argument handler
| $replace_funcs       | yes/no    | If the init funcs will be replaced (see `$func_xxx` variables)
| $func_cbegin         | string    | Function to use instead cbegin
| $func_cinfo          | string    | Function to use instead cinfo
| $func_cwarn          | string    | Function to use instead cwarn
| $func_cerror         | string    | Function to use instead cerror
| $func_cend           | string    | Function to use instead cend
| enable_init_script() | function  | Commands to enable initrc script
