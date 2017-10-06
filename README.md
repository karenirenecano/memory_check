# Memory Check Bash Script

This is a simple bash script for checking memory usage. Arguments are non-positional and are all required. Arguments are as follows:

```[-c <critical%>] ```<br>- Critical argument should be a number in percent. (e.g 90) and should always be greater than the warning argument.<br>
```[-w <warning%>]  ```<br>- Warning argument should be a number in percent. (e.g 60) and should always be less than the critical argument.<br>
```[-e <email>]     ```<br>- Email argument is a text string for an email receipient for memory check notification. The smtp feature is not a scope for this script.<br>

## Getting Started

You can freely pull/clone this script. It has been tested on CentOS-6.9-x86_64-minimal.

## Installing
Allow Owner can read and write, and Group and Other can read, making it executable.<br>
```
chmod 775 memory_check.sh
```

## Running the bash
Sample usage <br>
```
./memory_check -c 90 -w 60 -e karenireneccano@gmail.com
```
## Authors

* **[Karen Irene Cano](mailto:karenireneccano@gmail.com)**
