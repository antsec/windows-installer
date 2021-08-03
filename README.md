# Thank you
We are glad to see you are installing our collectors. This script will guide you through the installation as much as possible.

If you have any questions, feel free to contact us through your known channels.

For those who come across this page and don't know what it is for. Visit https://www.antsec.io

# Support
If you are unsure of anything we are here to help. Contact us and we will aid you through the process of installing the collectors.

This installer provides a basic configuration out of the box, which might not suit your needs. Feel free to contact us for further configuration.

Currently this works on x64 Windows platforms. Tested platforms are:

* Windows clients: 7, 8, 10.
* Windows Server: 2008R2, 2012, 2012R2, 2016 & 2019.
* Microsoft Server Core: Windows Server 2012, 2012R2, 2016 & 2019.
* Microsoft Hyper-V server: 2012, 2016 & 2019.

# Components
The AntSec collector for Windows consists of 5 components.

* Event Collector (Winlog Beat)
  * Collection of logs from the Windows Event log.
* System collector (Metricbeat)
  * Collection of logs about the performance of the system.
* File Collector (Filebeat)
  * Collection of logs from files or receive logs from syslog which we forward to our central system.
* Network collector (Packetbeat)
  * Collection of logs of the network traffic of the system. In order for it to function, a WinPcap installation and license is also required.
* Sysmon
  * This writes usefull information (e.g. started processes and executables) to the Windows Event log so that they can be sent to our central system.

# Requirements
Please make sure the following requirements are available on the system:

* Installation executable for installation of AntSec collectors.
* Local Administrator Privileges.
* Certificate for connecting to our systems. The certificate is unique per customer.
* 64-bit operating system.
* Connection to athena.antsec.nl trough TCP port 7201.

# Installation

On some systems an custom installation or modification is required. The  systems below require an custom installation. Please consult the paragraph "Custom installations and modifications" for these systems.

* Domain Controllers
* IIS Servers

The steps below describe the manual installation of the AntSec collector with default settings. 

1. Place the installer on the server and run it.
2. Enter customer number.
3. Press next.
4. Select the collectors to be installed. In most cases, the standard selected collectors and options are sufficient. 
5. Check the information and press next.
6. When finished the collectors are installed. 

[[/images/services-geinstalleerd.png]]

Finalizing and starting the collectors.

* If we provided you with an installer with build-in certificate the services selected during the installation are automatically started. 
* If not, please read paragraph "Placing customer certificates".

# Placing customer certificates
## Installer with built-in certificate
If you have an installer with a built-in certificate, you only need to check whether the services are started.

## Installer without built-in certificate
Browse to the installation folder and place the received customer certificates under Certificates in the folder.

After placing the certificates the services can be started.

# Custom installations and modifications
On some systems an custom installation or modification is required. Only carry out these actions in consultation with us.

## Domain Controller installation
When installing on a Domain Controller, choose the "Domain Controller installation" option.

## IIS Server installation
On the systems where IIS is installed, a “Custom Installation” must take place. During installation, the following option must additionally be selected:

* AntSec File Collector
 * Local System Rights

The IIS logging must be activated separately. 
1. Browse to the installation folder
2. Open the filebeat folder
3. Open the modules.d folder
4. Rename the iis.yml.disabled to iis.yml
5. Restart the AntSec Filebeat service. 
6. After the restart IIS logging is being send.

# Silent installation
The steps below describe the silent installation of the AntSec collector. The following silent install parameters are supported.

Installing the AntSec collectors silently.
* `/VERYSILENT`

Choosing the components of the installation. Winlogbeat and Metricbeat are installed by default (if components are not entered).
* `/COMPONENTS="winlogbeat,winlogbeat\vsawinlogbeat,winlogbeat\configwinlogbeat"`

The following components can be entered. These are the same options as in the manual installation. For example, if you need Winlogbeat, install all three Winlogbeat components.
* `winlogbeat`
* `winlogbeat\vsawinlogbeat`
* `winlogbeat\configwinlogbeat`
* `metricbeat`
* `filebeat`
* `filebeat\vsafilebeat`
* `filebeat\configfilebeat`
* `packetbeat`
* `packetbeat\vsapacketbeat`
* `packetbeat\configpacketbeat`
* `sysmon`

The installation can then, for example, be performed silently with the command below.

* `"AntSec collector v7.4.2.5.exe" /VERYSILENT /ASnumber={enter customer number}`

The command can be run in a Command Prompt, Powershell or in a script.

The installation is active as long as the installation processes is active.

# Responsible Disclosure
If you come across any (possible) vulnerabilities or have any security considerations, please contact us at security@antsec.io
