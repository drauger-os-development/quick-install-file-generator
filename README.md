# Quick Install File Generator

**Version:** 0.1.3-alpha1
**License:** GPL-2.0
**Maintainer:** Thomas Castleman \<batcastle@draugeros.org\>

A command-line tool that generates [Quick Install files](quick-install-spec.md) by auto-detecting your current system's settings and prompting you for anything it can't determine automatically. The resulting file can be fed to a compatible installer (such as [Edamame](https://github.com/drauger-os-development/edamame)) to reproduce your configuration on a fresh install with minimal interaction — useful for reinstalling your own system quickly, or deploying a fleet of machines consistently.

---

## What is a Quick Install File?

A Quick Install file is a simple JSON file describing how a system should be installed — locale, timezone, keyboard layout, partitioning, user account, and install-time options. It is designed to be human-readable and writable by hand in under 15 minutes without any tooling.

When network settings or a wallpaper are included, the output becomes an **Advanced Quick Install File**: a `.tar.xz` archive containing the JSON config alongside any carried-over assets.

For the full format specification, see [`quick-install-spec.md`](quick-install-spec.md).

---

## Requirements

- Python 3.10 or newer
- Must be run with **root / administrator privileges** (required to read network configuration files)
- Must be run in an **interactive terminal** — if launched headlessly (e.g. by double-clicking), the tool will attempt to spawn a terminal automatically

**Linux only:** `lsblk` for drive detection, `localectl` or `setxkbmap` for keyboard detection (optional — all values can be overridden manually)

**Windows only:** Python 3.10+ from [python.org](https://www.python.org/downloads/) — Python is not pre-installed on Windows

---

## Installation

### Debian / Ubuntu and derivatives

Download the `.deb` from the [releases page](https://github.com/drauger-os-development/quick-install-file-generator/releases) and install it:

```bash
sudo dpkg -i quick-install-file-generator_*.deb
```

Python 3 will be pulled in automatically as a dependency.

### RPM-based distros (Fedora, openSUSE, RHEL, etc.)

Download the `.rpm` from the [releases page](https://github.com/drauger-os-development/quick-install-file-generator/releases) and install it:

```bash
sudo rpm -i quick-install-file-generator_*.rpm
```

### From source / Windows

No installation required. Clone the repo and run the script directly:

```bash
git clone https://github.com/drauger-os-development/quick-install-file-generator.git
cd quick-install-file-generator
sudo quick-install-file-generator
```

A symlink named `mkqif` (short for **M**a**k**e **Q**uick **I**nstall **F**ile) is also provided as a convenient shorthand:

```bash
sudo mkqif
```

On Windows, omit `sudo` and run from an Administrator terminal instead.

---

## Usage

```
quick-install-file-generator [options]

Options:
  -h, --help     Show the help message and exit
  -v, --version  Show the version number and exit
```

Running the tool with no arguments starts the interactive setup. It will:

1. Auto-detect your language, timezone, keyboard layout, hostname, and username from the current system
2. Let you confirm or override each detected value
3. Ask for anything it can't detect (password, partitioning, install options)
4. Optionally carry over your network settings and wallpaper
5. Write a `.json` or `.tar.xz` file to your chosen location

The output file will be owned by you, not root, even though the tool runs with elevated privileges.

### Example run (Linux)

```
$ sudo quick-install-file-generator

╔══════════════════════════════════════════════════════╗
║      Linux Quick-Install Config Generator            ║
╚══════════════════════════════════════════════════════╝

Running on Linux — most settings will be auto-detected.

── System Settings (press Enter to accept detected value) ──
  Language code (e.g. en, fr, de) [en]:
  Timezone (e.g. US/Eastern, Europe/London) [US/Eastern]:
  ...
```

---

## Platform Support

| Platform | Drive Detection | Keyboard Detection | Network Carry-Over |
|---|---|---|---|
| Linux | ✔ via `lsblk` | ✔ via `localectl` / `setxkbmap` | ✔ NetworkManager + netplan |
| Windows | ✖ manual entry | ✔ via PowerShell | ✔ synthesized netplan from Windows config |

Partition paths on Windows must be entered manually. Boot a Linux live environment and run `lsblk -dpno NAME,SIZE,MODEL` to identify the target drive before filling in the config on Windows.

---

## Security Notice

The output file contains your **password in plain text**. It is not encrypted or hashed. Do not share the file with anyone without first removing the `PASSWORD` field.

---

## Related Projects

- [Edamame](https://github.com/drauger-os-development/edamame) — the Drauger OS installer, which both generates and consumes Quick Install files
- [Quick Install File Specification](quick-install-spec.md) — the format spec, useful if you want to write a compatible installer or generate files programmatically
- [systemd-boot-manager](https://github.com/drauger-os-development/systemd-boot-manager) — manages the systemd-boot bootloader, including the Bootloader Compatibility Mode (`COMPAT_MODE`) supported by this tool

---

## Contributing

Pull requests are welcome. If you find a bug or want to request a feature, please open an issue on GitHub.

If you maintain a Linux installer and would like to add Quick Install file support, the [format specification](quick-install-spec.md) has everything you need. Adoption by other distros and installers is actively encouraged.
