Variables
=========

##### Variables by type
[Build paths](#buildpaths)  
[Project related](#project)  
[Project sources paths](#src)  
[CrossRC paths](#crossrc)  
[Platform](#os)  
[Install specific](#install)  

<a name="buildpaths"/>
## Build paths

| Variable           | Description                               |
|--------------------|-------------------------------------------|
| $basedir           | source project name, parent of src        |
| $distdir           | ${basedir}/dist                           |
| $workdir           | ${basedir}/work                           |    

<a name="project"/>
## Project related
 
| Variable           | Description                               |
|--------------------|-------------------------------------------|
| $name              | Name of project (source folder's name)    |
| $srcdir            | Source project directory                  |
| $src_workdir       | Directory to work the files               |
| $src_distdir       | Directory with the distribution files     |

<a name="src" />
##Project sources paths

| Variable           | Description                               |
|--------------------|-------------------------------------------|
| $src_gen_inc_dir   | ${src_inc_dir}/generic                    |
| $src_inc_dir       | ${srcdir}/include                         |
| $src_os_inc_dir    | ${src_inc_dir}/${os}                      |

<a name="crossrc" />
##CrossRC paths

| Variable           | Description                               |
|--------------------|-------------------------------------------|
| $crossrc           | CrossRC directory (build)                 |
| $incdir            | ${crossrc}/include                        |
| $osdir             | ${crossrc}/os                             |

<a name="os"/>
##Platform
| Variable           | Description                               |
|--------------------|-------------------------------------------|
| $kernel            | platform kernel (linux, bsd)              |
| $os                | ${os}.${vendor} (linux.debian, bsd.generic)
| $os_conf           | ${osdir}/${os}.sh                         |
| $vendor            | platform vendor (generic, ubuntu, debian) |


<a name="install"/>
##Install specific
| Variable           | Description                               |
|--------------------|-------------------------------------------|
| $initrcfile        | Init RC script path                       |
| $configfile        | Config file path                          |
