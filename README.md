# Quilibrium Backup Setup
## Introduction
This repository contains a script and configuration files to automate the backup of files to Storj using rclone. Follow these steps to set up and run the backup process on your machine.

## Prerequisites
Before starting, ensure you have the following:


A Storj account with an access grant and a configured bucket
rclone installed on your machine. For more information on storej setup refer to their [documentation](https://docs.storj.io/dcs/getting-started)
Basic familiarity with using the terminal
Step-by-Step Setup Guide

## 1. Clone the Repository
Clone this repository to your local machine to get the backup scripts and configuration files.

Open your terminal.

Run the following command to clone the repository in home folder:



```bash
git clone https://github.com/augustov58/quilibriumBackup.git 
```

Navigate to the cloned directory:


```bash
cd quilibriumBackup
```

## 2. Install and Configure rclone
Install rclone:

If rclone is not already installed, you can install it using the following commands:

On Debian/Ubuntu:


```bash
sudo apt update
sudo -v ; curl https://rclone.org/install.sh | sudo bash
```

On macOS (using Homebrew):

```bash
brew install rclone
```
For other operating systems, follow the installation instructions on rclone's official website.

Configure rclone:

Use the provided template to configure rclone for Storj.

Copy the template configuration file:

```bash
cp rclone.conf.template ~/.config/rclone/rclone.conf
```

Edit the configuration file to add your Storj access grant and bucket name:

```bash
nano ~/.config/rclone/rclone.conf
```
Replace the placeholders access_key and secret_key with your actual Storj credentials. Save and exit the editor.

## 3. Set Up the Backup Script
Make the script executable:

Make sure the backup_to_storj.sh script has executable permissions:

```bash
chmod +x backup_to_storj.sh
```
Run the script:

Execute the script to configure your backup:

```bash
./backup_to_storj.sh
```

The script will prompt you to enter the following information:

The full path of the directory you want to back up (e.g., /home/user/documents)
The destination path on Storj (e.g., storj:bucket/path)
The time for daily backup in HH:MM format (24-hour clock, e.g., 02:00 for 2:00 AM)
The script will save these configurations and set up a cron job to run the backup daily at the specified time.

## 4. Verify the Cron Job
Check that the cron job is set up correctly:

```bash
crontab -l
```
You should see an entry similar to the following:


00 02 * * * /path/to/your/backup_to_storj.sh
This indicates that the script will run daily at 2:00 AM. Adjust the time according to the input you provided.

## 5. Testing and Troubleshooting
Test the backup:

Run the backup script manually to test it:

```bash
./backup_to_storj.sh
```
Check the destination on Storj to ensure the files are copied correctly.

Check the log file:

The script logs backup activities to a log file (~/backup.log). Review this file to troubleshoot any issues:

```bash
cat ~/backup.log
```

Additional Information
Security: Ensure your credentials and access tokens are handled securely. Do not hard-code sensitive information in your scripts or configuration files.
Cron Job Management: Use crontab -e to edit cron jobs if you need to change the schedule.

Conclusion
By following this guide, you should have successfully set up an automated backup process to Storj using rclone. Your files will now be securely backed up on a daily basis, ensuring that your data is protected and easily recoverable.

For any further assistance or issues, please refer to the rclone documentation or contact the repository maintainer.
