# steamdeck-bt-reconnect 

## About

The aim of the project is to provide missing feature of steamdeck: to reconnect all previously connected Bluetooth devices again, after waking up from sleep by power button.

## Installation
**WARNING**: Never execute code on your system without looking at it first and understanding what it does.

1) Open steam deck in Desktop mode and in terminal paste next string:
```bash
curl -s https://raw.githubusercontent.com/usualstuff/steamdeck-bt-reconnect/main/install.bash | sudo bash
```
2) Return to the usual steam deck mode
3) Connect to your bluetooth devices via settings.

## Uninstallation

Run `sudo bash /opt/steamdeck-bt-reconnect/uninstall.bash` and remove `/opt/steamdeck-bt-reconnect` directory by hand.


## License
The code is provided AS IS and I bear no responsibility in case of any hardware or software failures.
This project is licensed under the MIT license. Feel free to edit and distribute this template as you like.

See [LICENSE](https://github.com/usualstuff/steamdeck-bt-reconnect/blob/main/LICENSE) for more information.
