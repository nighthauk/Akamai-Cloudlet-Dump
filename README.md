# Akamai Cloudlet Dump

This is a simple bash script to automate the dump of cloudlet policies from Akamai using the [Cloudlets CLI](https://github.com/akamai/cli-cloudlets/). First, the script will dump the full list of policies in csv format, which will then serve as our list to execute individual request to grab each policy and write to its respective json file.

## Requirements
* Akamai CLI installed
* Akamai Cloudlets CLI module installed
* Edgegrid credentials provisioned with necessary grant
* This has only been tested on MacOS

## Credentials
In order to use this, you need to:
* Install the Akamai CLI with the Cloudlets module.
* Set up your credential files as described in the [authorization](https://developer.akamai.com/introduction/Prov_Creds.html) and [credentials](https://developer.akamai.com/introduction/Conf_Client.html) sections of the getting started guide on developer.akamai.com.  
* When working through this process you need to give your API credential the "Cloudlets Policy Manager" grant.  This script assumes that the --section <name> being used is 'default' within your .edgerc file. Will likely update to make this dynamic as time permits.

## Cloudlet Types
Here is the list of cloudlets and cloudlet type codes. 

```xml
API Prioritization = AP
Application Load Balancer = ALB
Audience Segmentation = AS
Edge Redirector = ER
Forward Rewrite = FR
Input Validation = IV
Phased Release = CD
Request Control = IG
Visitor Prioritization = VP
```

## Usage
* First we need to make the script executable
```bash
$ chmod +x cloudlets.sh
```
* Second, we retrieve the SwitchKey for the account, and pass that to the script upon init. (ex: ./cloudlets.sh AB-3A:4-1G3XX)
```bash
$ ./cloudlets.sh ${switchKey}
```
* Assuming that the CLI doesn't timeout, a new directory should be created at the location chosen, which will contain a json file for each policy upon completion.