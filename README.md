# rtf-config-helper
A simple helper script for generating RTF config files

## Usage

* Download the script into a folder of your choice.
* [Optional] Provide your MuleSoft `license.lic` into the same folder.
* Run `rtf-config-helper.sh`
* You will be prompted to download and unzip the RTF installations scripts from MuleSoft if they are not already available.
* Enter your controller and worker IP addresses when prompted. You may add multiple IP addresses for controllers and workers; leave a blank entry when you have no more to add.
* Enter your device names for the dockerd and etcd devices.
* Enter your RTF activation data from Anypoint.
* Enter your Base-64 encoded license file data, or leave blank to automatically import from `license.lic`.
* Verify your configuration values and enter `y` to generate the RTF node configuration.
