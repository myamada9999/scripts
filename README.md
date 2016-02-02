# scripts
Personal collection of scripts.

git-pull-all.sh
---------------

This script run git pull to each directories in ~/git-repositories.

 $ ./git-pull-all.sh

create-ltsi-kernel.sh
---------------------

This script is to create ltsi-kernel tree by TAG name.

Run script with TAG name.

 $ ./create-ltsi-kernel.sh ${TAG}

EX: ${TAG} is v4.1.17.

If you have a local git server for linux-stable.git and ltsi-kernel.git,

please set $LOCAL_GIT_SERVER in create-ltsi-kernel.sh.

