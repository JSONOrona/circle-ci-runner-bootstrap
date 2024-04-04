# CircleCI Self-Hosted Runner Setup Script

This script automates the setup and uninstallation of a CircleCI self-hosted runner on a Linux-based system. It handles the installation of necessary dependencies, the CircleCI runner itself, and configures the runner to start automatically. Additionally, the script supports uninstalling the runner.

## Prerequisites

Before running the script, ensure you have:
- A Linux-based server (Ubuntu/Debian recommended) with internet access.
- Administrative (root) access to the server.
- Your CircleCI organization name, runner resource class, and a runner token generated from the CircleCI web interface.

## Usage

### Installation

To install the CircleCI self-hosted runner, use the following command syntax:

```bash
./setup_circleci_runner.sh -o <organization> -r <resource class> -t <runner token>
```

- `-o <organization>`: Your CircleCI organization name.
- `-r <resource class>`: The resource class defined for your runner.
- `-t <runner token>`: The runner token generated from CircleCI.

Example:

```bash
./setup_circleci_runner.sh -o my-org -r my-resource-class -t ABC123DEF456
```

This will install all necessary components, configure the runner, and start it as a service.

### Uninstallation

To uninstall the CircleCI self-hosted runner, run the script with the `-u` option:

```bash
./setup_circleci_runner.sh -u
```

This command stops the runner service, removes the CircleCI launch agent, and cleans up related configurations.

### Help

For help and a list of available options, use the `-h` flag:

```bash
./setup_circleci_runner.sh -h
```

## Customization

The script is designed for straightforward setups. If your setup requires additional customization (e.g., using a proxy, setting up on a different Linux distribution, or configuring multiple runners), you may need to modify the script accordingly or perform some steps manually.

## Contributing

Contributions to the script are welcome! If you have improvements or bug fixes, please submit a pull request or open an issue.

