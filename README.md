# voacapl-docker

Docker runner script for VOACAP in Linux
(see: [jawatson/voacapl](https://github.com/jawatson/voacapl)).

By making use of docker, we can have an isolated container that allows us to execute
VOACAP commands without polluting our Linux system's environment with build-tools or
files and symlinks related to voacapl.

The docker-image is created with a *voacap* user whose home directory is located at
`/home/voacap` containing the *itshfbc* VOACAP runtime directory.

# Usage

First, clone the repository by running the following command:

```bash
git clone https://github.com/wcmatthysen/voacapl-docker.git voacapl-docker
```

To initialize the environment just run the `./voacapl` script in the *voacapl-docker*
directory as follows:

```bash
cd voacapl-docker
./voacapl
```

This will pull the docker-image and fetch the *run* and *areadata* directories from
the [jawatson/voacapl](https://github.com/jawatson/voacapl) repository.

For subsequent invocations you can run the command as you would normally run the
`voacapl` command. However, keep in mind that the *itshfbc* folder is located inside
the docker-container in the voacap user's home directory (i.e. `/home/voacap/itshfbc`).

So, to do a point-to-point calculation you can run the following command:

```bash
./voacapl /home/voacap/itshfbc voacapx.dat voacapx-out.dat
```

This will invoke the `voacapl` command inside the container, specifying that it should
use `/home/voacap/itshfbc` as the VOACAP runtime directory. The *voacapx.dat* file is
specified as input file for the command. This file is available to the container's
`voacapl` command because the *run* directory is mounted as a volume inside the container
at `/home/voacap/itshfbc/run`. Any output written to this *run* directory is then available
to the host as well. This means that you'll see the output file *voacapx-out.dat* being
written to the *run* directory (in the *voacapl-docker* folder) because it is synchronized
with the *run* directory inside the container.

To do an area-based calculation you can run the following command:

```bash
./voacapl /home/voacap/itshfbc area calc default/default.voa
```

This works similarly to the above-mentioned point-to-point command. However, the input
file is read from the *areadata* instead of the *run* directory. In this case, the
input file is located in the *default* sub-directory of the *areadata* directory.
The output file will then be written to the same directory (`areadata/default`) with
a matching filename, and only the extension being changed to *vg1*.
