# Homarr as a Home Assistant app

[Homarr](https://homarr.dev/) is a sleek and modern dashboard for your home server. This Home Assistant app (formerly known as an add-on) runs the application on the Home Assistant Operating System or Supervised installations.

## Installation

1. Go to the app store page in your Home Assistant instance.
2. Add this repository URL to your app store or you can click this button

    [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2FWiggen94%2Fha-homarr-v1-server)

3. Look up and install "Homarr".
4. **Optional:** Set the app's configurations. You don't need to change any of the default configuration for Homarr to run.
5. Start the app and check the logs to ensure everything is running smoothly.
6. Open Homarr by clicking "Open Web UI" or at `http://<your-home-assistant-ip>:7575`.

Saved data are stored in `/share/homarrv1` in your Home Assistant installation. You may access them using [Samba](https://github.com/home-assistant/addons/tree/master/samba) by going to `\\your-home-assistant-ip\share\homarrv1\`.

## Updating

Whenever a newer release of Homarr is available, you can update by clicking on Rebuild on Homarr's app page in Home Assistant. Please open an issue if you face difficulties updating.

## Migration from Homarr v0.x

Homarr v1+ is a complete rewrite that is not directly compatible with prior versions. If you're upgrading from Homarr v0.x:

1. **Export from v0.x**: Go to your old Homarr v0.x dashboard and export your boards and configurations.
2. **Install v1**: Install the new Homarr v1 addon.
3. **Import to v1**: Go to the new Homarr v1 dashboard and import your exported data.
4. **Access**: Same URL: `http://<your-home-assistant-ip>:7575`.

**Note**: Migration is NOT automatic. You must manually export from v0.x and import to v1.

**For detailed migration instructions, see the [official Homarr migration guide](https://homarr.dev/blog/2025/01/19/migration-guide-1.0/).**

## Documentation

For more detailed setup and configuration instructions, visit [Homarr's official documentation]([https://homarr.dev/docs/about](https://homarr.dev/docs/getting-started/)).

## Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/Wiggen94/ha-homarr-v1-server/issues).

## Show Your Support

Give a ⭐️ if this project helped you or if you find it interesting!

<a href="https://www.buymeacoffee.com/croome" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>
