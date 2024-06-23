const hyprland = await Service.import("hyprland");
const notifications = await Service.import("notifications");
const audio = await Service.import("audio");
const battery = await Service.import("battery");
const systemtray = await Service.import("systemtray");
import bright from "service/bright";
import { LOGO, DATE } from "Var";

function range(length: number, start = 1) {
  return Array.from({ length }, (_, i) => i + start);
}
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
    label: DATE.bind(),
    css: "color:pink;font-size:20px;",
  });
}

function Brightness() {
  return Widget.Button({
    on_scroll_up: () => (bright.screen_value += 0.02),
    on_scroll_down: () => (bright.screen_value -= 0.02),
    child: Widget.Label({
      label: bright.bind("screen_value").as((v) => `󰃠 ${Math.floor(v * 100)}%`),
      css: "color:#FA8B64;",
    }),
  });
}
function Volume() {
  return Widget.Button({
    on_scroll_up: () => (audio.speaker.volume += 0.02),
    on_scroll_down: () => (audio.speaker.volume -= 0.02),
    on_clicked: () => (audio.speaker.volume = audio.speaker.volume > 0 ? 0 : 1),
    child: Widget.Label({
      label: audio.speaker.bind("volume").as((v) => {
        const percent = Math.floor(v * 100);
        let icon: string;
        if (percent > 100) {
          icon = "󰕾";
        } else if (percent > 50) {
          icon = "󰖀";
        } else if (percent > 0) {
          icon = "󰕿";
        } else {
          icon = "󰸈";
        }
        return `${icon} ${percent}%`;
      }),
      css: "color:#FF5AAA;",
    }),
  });
}
function Wallpaper() {
  return Widget.Button({
    on_primary_click: () =>
      Utils.execAsync(["bash", "-c", "~/.config/hypr/scripts/change_bg.sh"]),
    child: Widget.Label({
      label: "󰸉",
      css: "color:#C896FF;",
    }),
  });
}
function Battery() {
  return Widget.Button({
    child: Widget.Label({
      class_name: "battery",
      label: battery.bind("percent").as((p) => {
        if (p === 100) {
          return "󰁹";
        } else if (p > 90) {
          return "󰂂";
        } else if (p > 80) {
          return "󰂁";
        } else if (p > 70) {
          return "󰂀";
        } else if (p > 60) {
          return "󰁿";
        } else if (p > 50) {
          return "󰁾";
        } else if (p > 40) {
          return "󰁽";
        } else if (p > 30) {
          return "󰁼";
        } else if (p > 20) {
          return "󰁺";
        } else {
          return "󰂃";
        }
      }),
      setup: (self) => {
        self.hook(battery, () => {
          self.toggleClassName("charging", battery.charging === true);
        });
      },
    }),
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

const icon = Widget.Icon({
  icon: LOGO.bind(),
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
    children: [],
  });
}

function Right() {
  return Widget.Box({
    hpack: "end",
    css: "font-size:20px;",
    spacing: 4,
    children: [Wallpaper(), Volume(), Brightness(), Battery(), SysTray()],
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
