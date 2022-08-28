
# Export to QIF/CSV from 28degrees Master Card website


## Description

This utility logs into https://28degrees-online.latitudefinancial.com.au website, using
your username and password, and simply grabs all your transactions from there,
saving them into QIF file.


## Installation

You will need some things for this tool to work:

1. Python 3
1. WebDriver
1. Selenium

On OS X, you can use `brew` to install N 2 & 3 by:

    `brew install chromedriver`
    `pip install selenium`

As installation instructions for the things above vary for different platforms,
I assume you know how install them, otherwise please let me know and I'll
extend this section with detailed steps for your platform.

### Ubuntu

__Note: if the below doesnt work then install the steps as per the docker file (adding sudo where neccessary)__
__TODO: replace the below with correct steps__

To setup the environment:

```sh
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb --fix-broken
google-chrome

sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

sudo apt update && sudo apt -y upgrade
sudo apt install -y python3-pip
sudo apt install -y build-essential libssl-dev libffi-dev python3-dev
sudo apt install -y python3-venv
sudo apt install chromium-chromedriver
apt-get install -y libglib2.0 libnss3 libgconf-2-4 libfontconfig1

mkdir -p ~/dev/python/environments
cd ~/dev/python/environments
python3 -m venv 28deg
source ~/dev/python/environments/28deg/bin/activate
pip install selenium webdriver-manager
deactivate
```

To execute the script from this directory:

```sh
source ~/dev/python/environments/28deg/bin/activate
python export.py --captcha --csv
deactivate
```


## Usage

Simply start `export.py` in your shell of choice (cmd.exe, bash, zsh etc).
You will be prompted for your username & password. **THESE details will not be
used for anything but logging into the 28degrees' website.**

If your Internet connection is slow (because Australia), or 28degrees site is being particularly
slow today, and you see errors/exceptions in the console, use `--slow` command line parameter, which
will increase connection timeout to 25 seconds. I know right, we're not here to fuck spiders.

Then the tool will go through several stages, printing some supplementary information
into console. Do not worry about that unless these are actually error
messages.

When it's done, you should see file that looks like `YYYY.MM.DD-YYYY.MM.DD.qif` under
the 'export' folder, where YYYY.DD.MM are the dates for the first and last transactions
in the exported dataset. It will also create a transactions.db file (sqlite database) but
you can ignore this one - we simply need it to keep track of transactions that have already
been recorded.

If you want to re-start the process, just delete (or re-name, which is safer) transactions.db file.

## Docker

The docker is not working as there is a captcha interaction needed and the display is not exported. If you want to fix
it make sure you uncomment line 78 and comment line 79 in export.py.

## Errors / support

As this is a very first and rough cut of the tool, errors to be expected - please **DO**
let me know of any issues you have with it.

Also please feel free to submit your ideas/improvement suggestions.


## Disclaimer

I am not affiliated in any way with this website, and this utility has not been
endorsed or banned by the company-operator of the website.

Please feel free to use it and report on any issues/bug/problems, yet you shall
agree beforehand that you are using this utility at your own risk - I accept
no liability whatsoever for anything what can possibly go wrong.
