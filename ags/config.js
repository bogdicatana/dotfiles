import { applauncher } from "./applauncher.js";

const logoutButton = Widget.Button({
  class_name: "logout",
  child: Widget.Icon({
    icon: "system-log-out-rtl-symbolic",
    css: " font-size: 90 ",
  }),
  onClicked: () => Utils.exec("hyprctl dispatch exit"),
});

const powerButton = Widget.Button({
  class_name: "power",
  child: Widget.Icon({
    icon: "system-shutdown-symbolic",
    css: " font-size: 90 ",
  }),
  onClicked: () => Utils.exec("systemctl poweroff"),
});

const sleepButton = Widget.Button({
  class_name: "sleep",
  child: Widget.Icon({
    icon: "system-suspend-symbolic",
    css: " font-size: 90 ",
  }),
  onClicked: () => Utils.exec("systemctl suspend"),
});

const restartButton = Widget.Button({
  class_name: "restart",
  child: Widget.Icon({
    icon: "system-reboot-symbolic",
    css: " font-size: 90 ",
  }),
  onClicked: () => Utils.exec("systemctl reboot"),
});

const searchButton = Widget.Button({
  class_name: "search",
  child: Widget.Icon({
    icon: "system-search-symbolic",
    css: " font-size: 90 ",
  }),
  onClicked: () => App.toggleWindow("applauncher"),
});

const buttonBox = Widget.Box({
  "class-name": "button-box",
  vertical: false,
  children: [
    powerButton,
    restartButton,
    sleepButton,
    logoutButton,
    searchButton,
  ],
  css: "margin-left: 10px; margin-top: 10px; margin-bottom: 10px; margin-right: 10px;",
});

const userProfile = Widget.Box({
  vertical: false,
  children: [
    Widget.Icon({
      icon: "wave-avatar",
      css: " font-size: 90 ",
    }),
    Widget.Box({
      vertical: true,
      hpack: "center",
      vpack: "center",
      children: [
        Widget.Label({
          label: "Bogdan",
          css: " font-size: 30;",
        }),
        Widget.Label({
          label: "Cave Dweller",
          css: " font-size: 20; color: #6F6E7C;",
        }),
      ],
      css: "margin-left: 10px;",
    }),
  ],
  css: "margin-top: 10px;",
});

const userPanel = Widget.Box({
  vertical: false,
  hpack: "center",
  children: [userProfile],
});

const menu = () =>
  Widget.Window({
    name: "menu",
    class_name: "menu",
    exclusivity: "exclusive",
    hpack: "center",
    vpack: "center",
    anchor: ["top", "left"],
    keymode: "on-demand",
    margins: [10, 10, 10, 10],
    child: Widget.Box({
      vertical: true,
      children: [userPanel, buttonBox],
    }),
  });

App.config({
  style: "./style.css",
  windows: [menu(), applauncher],
});
