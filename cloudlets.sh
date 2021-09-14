#!/bin/bash

# So we skip over the first line of the csv
HEAD=1

# Grab a dump of all cloudlets per account-key
get_cloudlets () {
    ###############################################################################################
    ### NOTE: The underlying API this CLI calls often takes so long that the CLI actually fails.
    ###       If it fails, this too will fail and is beyond the control of this script. If at first
    ###       you don't succeed, dust yourself off and try again.
    ###############################################################################################
    akamai cloudlets --section default --account-key ${1} list --csv
    sleep 3
}

# Setup/create our path to write json files
create_path () {
    while read -p "Enter the folder name for output (starting from $HOME): " -r file_dir
    do
        if [ -d ~/"${file_dir}" ]; then
            echo "~/${file_dir} already exists.."
        else
            mkdir -p ~/"${file_dir}"
            break
        fi
    done
}

# Call to setup directory and run the main dump
create_path
echo "Getting cloudlets for SwitchKey ${1}"
CSV=$(get_cloudlets ${1})

# Step through each Policy ID, grabbing output and write to json
while IFS="," read -r policyid policyname ctype group
do
    test $HEAD -eq 1 && ((HEAD=HEAD+1)) && continue
    echo "Getting Cloudlet ID: $policyid, Policy Name: $policyname, Type: $ctype, Group: $group";
    
    echo "${file_dir}"
    akamai cloudlets --section default --account-key ${1} retrieve --policy-id $policyid > ~/"${file_dir}"/$policyname-$policyid.json
    sleep 2
done <<< "$CSV"