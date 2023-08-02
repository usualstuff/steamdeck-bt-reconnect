# steamdeck-bt-reconnect 

## About

The project aims to provide the missing feature of SteamDeck: to reconnect all previously connected Bluetooth devices again, after waking up from sleep by power button.

## Installation
**WARNING**: Never execute code on your system without looking at it first and understanding what it does.

1) Open Steamdeck in Desktop mode and in a terminal paste the next string:
```bash
curl -s https://raw.githubusercontent.com/usualstuff/steamdeck-bt-reconnect/main/install.bash | sudo bash
```
2) Return to the usual steam deck mode
3) Connect to your Bluetooth devices via settings.

## Uninstallation

Run `sudo bash /opt/steamdeck-bt-reconnect/uninstall.bash` and remove `/opt/steamdeck-bt-reconnect` directory by hand.

## How this is works
[save-bt-devices.service](https://github.com/usualstuff/steamdeck-bt-reconnect/blob/main/save-bt-devices.service) instructs systemd to run [save_devices](https://github.com/usualstuff/steamdeck-bt-reconnect/blob/main/save-bt-devices.service#L8) function of [bt-control.bash](https://github.com/usualstuff/steamdeck-bt-reconnect/blob/main/bt-control.bash) when the system goes to sleep, which in turn will query the Bluetooth driver with `bluetoothctl` utility to find any connected Bluetooth device addresses and save them to file.

[restore-bt-devices.services](https://github.com/usualstuff/steamdeck-bt-reconnect/blob/main/restore-bt-devices.service) instructs systemd to run [restore_devices](https://github.com/usualstuff/steamdeck-bt-reconnect/blob/main/bt-control.bash#L25) function of [bt-control.bash](https://github.com/usualstuff/steamdeck-bt-reconnect/blob/main/bt-control.bash) when the system wakes up, and loop over addresses in the file, executing `bluetoothctl` again to try to connect to them again.

Notice the `StartLimitBurst=10` and `StartLimitIntervalSec=1` parameters in [restore-bt-devices.service](https://github.com/usualstuff/steamdeck-bt-reconnect/blob/main/restore-bt-devices.service#L4) - this was added because, for some initial moments after waking up, the Bluetooth driver of SteamDeck is unavailable, so a couple of retries are needed even if there is the explicit dependency on `bluetooth.target` in [After](https://github.com/usualstuff/steamdeck-bt-reconnect/blob/main/restore-bt-devices.service#L3) section of [restore-bt-devices.service](https://github.com/usualstuff/steamdeck-bt-reconnect/blob/main/restore-bt-devices.service).

## License
The code is provided AS IS and I bear no responsibility in case of any hardware or software failures.
This project is licensed under the MIT license.

See [LICENSE](https://github.com/usualstuff/steamdeck-bt-reconnect/blob/main/LICENSE) for more information.
