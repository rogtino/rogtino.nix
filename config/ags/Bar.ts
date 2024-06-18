import GLib from "gi://GLib";
const hyprland = await Service.import("hyprland");
const notifications = await Service.import("notifications");
const mpris = await Service.import("mpris");
const audio = await Service.import("audio");
const battery = await Service.import("battery");
const systemtray = await Service.import("systemtray");
import bright from "service/bright";

function range(length: number, start = 1) {
  return Array.from({ length }, (_, i) => i + start);
}
const date = Variable("", {
  poll: [1000, 'date "+%H:%M"'],
});
const Workspaces = (ws: number) =>
  Widget.Box({
    className: "workspaces",
    children: range(ws || 20).map((i) =>
      Widget.Label({
        attribute: i,
        vpack: "center",
        label: `${i}`,
        setup: (self) =>
          self.hook(hyprland, () => {
            self.toggleClassName("active", hyprland.active.workspace.id === i);
            self.toggleClassName(
              "occupied",
              (hyprland.getWorkspace(i)?.windows || 0) > 0,
            );
          }),
      }),
    ),
    setup: (box) => {
      if (ws === 0) {
        box.hook(hyprland.active.workspace, () =>
          box.children.map((btn) => {
            btn.visible = hyprland.workspaces.some(
              (ws) => ws.id === btn.attribute,
            );
          }),
        );
      }
    },
  });

function Clock() {
  return Widget.Label({
    class_name: "clock",
    label: date.bind(),
    css: "color:pink;font-size:16px",
  });
}

// we don't need dunst or any other notification daemon
// because the Notifications module is a notification daemon itself
function Notification() {
  const popups = notifications.bind("popups");
  return Widget.Box({
    class_name: "notification",
    visible: popups.as((p) => p.length > 0),
    children: [
      Widget.Icon({
        icon: "preferences-system-notifications-symbolic",
      }),
      Widget.Label({
        label: popups.as((p) => p[0]?.summary || ""),
      }),
    ],
  });
}

function Media() {
  const label = Utils.watch("", mpris, "player-changed", () => {
    if (mpris.players[0]) {
      const { track_artists, track_title } = mpris.players[0];
      return `${track_artists.join(", ")} - ${track_title}`;
    } else {
      return "Nothing is playing";
    }
  });

  return Widget.Button({
    class_name: "media",
    on_primary_click: () => mpris.getPlayer("")?.playPause(),
    on_scroll_up: () => mpris.getPlayer("")?.next(),
    on_scroll_down: () => mpris.getPlayer("")?.previous(),
    child: Widget.Label({ label }),
  });
}

function Brightness() {
  const bri = Widget.CircularProgress({
    css:
      "min-width: 30px;" + // its size is min(min-height, min-width)
      "min-height: 30px;" +
      "font-size: 6px;" + // to set its thickness set font-size on it
      "background-color: @theme_bg_color;" + // set its bg color
      "color: pink;", // set its fg color
    rounded: true,
    inverted: false,
    startAt: 0.75,
    value: bright.bind("screen_value").as((p) => p),
    child: Widget.Icon({
      icon: "",
      css: "font-size:0px",
    }),
  });
  return Widget.Button({
    on_scroll_up: () => (bright.screen_value += 0.02),
    on_scroll_down: () => (bright.screen_value -= 0.02),
    child: bri,
  });
}
function Volume() {
  const sound = Widget.CircularProgress({
    css:
      "min-width: 30px;" + // its size is min(min-height, min-width)
      "min-height: 30px;" +
      "font-size: 6px;" + // to set its thickness set font-size on it
      "background-color: @theme_bg_color;" + // set its bg color
      "color: green;", // set its fg color
    rounded: false,
    inverted: false,
    startAt: 0.75,
    value: audio.bind("speaker").as((a) => a.volume),
    child: Widget.Icon({
      icon: "",
      css: "font-size:0px",
    }),
  });

  return Widget.Button({
    on_scroll_up: () => (audio.speaker.volume += 0.02),
    on_scroll_down: () => (audio.speaker.volume -= 0.02),
    child: sound,
  });
}
function Battery() {
  const bat = Widget.CircularProgress({
    css:
      "min-width: 30px;" + // its size is min(min-height, min-width)
      "min-height: 30px;" +
      "font-size: 6px;" + // to set its thickness set font-size on it
      "margin: 4px;" + // you can set margin on it
      "background-color: @theme_bg_color;" + // set its bg color
      "color: aqua;", // set its fg color
    rounded: true,
    inverted: false,
    startAt: 0.75,
    value: battery.bind("percent").as((p) => p / 100),
    child: Widget.Label({
      label: "",
      css: "font-size:0px",
    }),
  });

  return Widget.Button({
    child: bat,
  });
}

function SysTray() {
  const items = systemtray.bind("items").as((items) =>
    items.map((item) =>
      Widget.Button({
        child: Widget.Icon({ icon: item.bind("icon") }),
        on_primary_click: (_, event) => item.activate(event),
        on_secondary_click: (_, event) => item.openMenu(event),
        tooltip_markup: item.bind("tooltip_markup"),
      }),
    ),
  );

  return Widget.Box({
    children: items,
  });
}
const ivar = Variable(GLib.get_os_info("LOGO"));

const icon = Widget.Icon({
  icon: ivar.bind(),
  css: "font-size:22px;margin-left:8px",
});
// layout of the bar
function Left() {
  return Widget.Box({
    spacing: 8,
    children: [icon, Workspaces(7), Clock()],
  });
}

function Center() {
  return Widget.Box({
    spacing: 8,
    children: [Media(), Notification()],
  });
}

function Right() {
  return Widget.Box({
    hpack: "end",
    spacing: 8,
    children: [Volume(), Brightness(), Battery(), SysTray()],
  });
}

export const Bar = Widget.Window({
  name: `bar`, // name has to be unique
  class_name: "bar",
  anchor: ["top", "left", "right"],
  exclusivity: "exclusive",
  child: Widget.CenterBox({
    start_widget: Left(),
    center_widget: Center(),
    end_widget: Right(),
  }),
});
