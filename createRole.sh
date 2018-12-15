#!/bin/bash
function _usage {
	echo >&2 "Usage: $(basename $0) -n RoleName [-t targetDir]"
	echo >&2 "Provide the role name to be created with -n."
	echo >&2 "If the -t option is not provided, the role will be created in the current directory."
	exit 3
}

while getopts ":n:t:" opt
do
	case "$opt" in
	  n) rolename="$OPTARG";;
	  t) targetDir="$OPTARG";;
	 \?) _usage;;
	esac
done
shift `expr $OPTIND - 1`

if [[ -z $rolename ]]; then
	_usage
fi

if [[ -z $targetDir ]]; then
	targetDir=$(pwd)
fi

if [[ -d ${targetDir}/${rolename} ]]; then
	echo >&2 "Folder with name '$rolename' already exists in target '$targetDir'. Exiting for safety"
	exit 3
fi

echo  "Creating role $rolename in directory $targetDir"
#Create the directories that will have a main.yml
for d in tasks handlers vars defaults meta; do
	subdir=${targetDir}/${rolename}/${d}
	mkdir -p $subdir
	echo "---" > ${subdir}/main.yml
done

#Create directories for files and templates with a default README file so we can build the scaffolding of the directory structure in git.
for d in files templates; do
	subdir=${targetDir}/${rolename}/${d}
	mkdir -p $subdir
	touch ${subdir}/README
done
