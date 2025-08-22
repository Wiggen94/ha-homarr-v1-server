# 🌐 Home Assistant Add-on: Homarr v1 Server 🚀

Welcome to the **Homarr v1 Server for Home Assistant** repository! This add-on is designed to host the Homarr v1 dashboard independently within your Home Assistant environment, providing easy and direct access to your self-hosted dashboard.

## 🎉 Features

- **Independent Hosting**: Seamlessly runs Homarr as a standalone service within Home Assistant.
- **Direct Access**: Homarr is available at `http://<your-home-assistant-ip>:7575`.
- **Persistent Storage**: Configurations and data are preserved across restarts.
- **Samba Access**: Data is accessible via Samba at `\\your-home-assistant-ip\share\homarrv1\`.

## 💡 About Homarr v1

Homarr v1+ is a complete rewrite of the popular self-hosted dashboard that allows you to centralize and manage access to your web services and frequently visited websites. It features a modern architecture with improved performance, better security, and enhanced customization options. Read more about Homarr [here](https://homarr.dev/).

## 🚀 Quick Start

1. **Install the Add-on**: Add this add-on to your Home Assistant instance from the add-on store.
2. **Run**: Start the add-on to get Homarr v1 up and running on port 7575.
3. **Access**: Open your browser and navigate to `http://<your-home-assistant-ip>:7575` to access your Homarr dashboard.

Your files are safely backed up to `/share/homarrv1` in your Home Assistant installation. 

## 🛠 Installation

1. Open your Home Assistant Supervisor panel and go to the Add-on store.
2. Add this repository URL to your add-on store or you can click this button

    [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2FWiggen94%2Fha-homarr-v1-server)

3. Install the "Homarr v1 Server" add-on.
4. Start the add-on and check the logs to ensure everything is running smoothly.
5. Access Homarr at `http://<your-home-assistant-ip>:7575`.

## 🔄 Migration from Homarr v0.x

If you're upgrading from Homarr v0.x:

1. **Export from v0.x**: Go to your old Homarr v0.x dashboard and export your boards and configurations.
2. **Install v1**: Install the new Homarr v1 addon.
3. **Import to v1**: Go to the new Homarr v1 dashboard and import your exported data.
4. **Access**: Same URL: `http://<your-home-assistant-ip>:7575`.

**Note**: Migration is NOT automatic. You must manually export from v0.x and import to v1.

**For detailed migration instructions, see the [official Homarr migration guide](https://homarr.dev/blog/2025/01/19/migration-guide-1.0/).**

## Updating

Whenever there's an update to Homarr you can try updating the addon by rebuilding on the addon-page in Home Assistant. However, there is no guarantee that it will work. Please open an issue if you face difficulties after upgrading.

## 📚 Documentation & Support

For more detailed setup and configuration instructions, visit [Homarr's official documentation]([https://homarr.dev/docs/about](https://homarr.dev/docs/getting-started/)).

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/Wiggen94/ha-homarr-v1-server/issues).

## 🌟 Show Your Support

Give a ⭐️ if this project helped you or if you find it interesting!

<a href="https://www.buymeacoffee.com/croome" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>
