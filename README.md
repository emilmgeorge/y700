# Y700

Lenovo Y700 scripts and patches.

**Disclaimer:** The contents of this repo are provided AS-IS (see LICENSE file). Author is not responsible for any damages.

## Enabling Subwoofer on Linux
Y700 Subwoofer does not work by default on linux. For the subwoofer to work, its external amplifier has to be powered up by setting GPIO2 of the codec chip. Appropriate pin config is also required.

The provided patch can be used to enable subwoofer until it is fixed in the kernel. It was tested on Lenovo Y700 15ISK (codec subsystem id: 0x17aa3827) running Arch Linux.

#### Steps
##### 1. Clone repo:
```
git clone https://github.com/emilmgeorge/y700.git
cd y700
```
##### 2. Install patch:

```
./subwoofer/installer.sh
```
To uninstall, use `--uninstall` flag in the above command.

### Known Issues
- A pop sound is heard when plugging in headphones or when the laptop is turning on/off/sleeping etc.


