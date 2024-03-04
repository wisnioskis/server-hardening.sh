## Server Hardening Script

This script automates the process of hardening your server by disabling password authentication via SSH, configuring fail2ban to protect against brute-force attacks, and setting up UFW (Uncomplicated Firewall) to allow only necessary connections.

### Installation

To install and run the script, execute the following command in your terminal:

```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/wisnioskis/server-hardening.sh/main/setup.sh)"
```

**Note:** This script must be run as root.

### Disclaimer

This script is provided as-is and should be used with caution. Ensure you understand the changes it makes to your system before running it. Always back up important data before making significant changes to your server configuration.

### Contributing

Feel free to contribute to this project by submitting issues or pull requests on [GitHub](https://github.com/wisnioskis/server-hardening.sh). Your feedback and contributions are highly appreciated!

### License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

For any questions or concerns, please contact me [here](https://l3pr.org/card).

---
You can view the repository [here](https://github.com/wisnioskis/server-hardening.sh).
