import { MUSIC, LIGHT } from "Var";
function Light() {
  return Widget.Box({
    vexpand: true,
    hexpand: true,
    vpack: "fill",
    css: "text-align:center;",
    setup: (box) =>
      box.hook(MUSIC, () => {
        box.toggleClassName("popup", MUSIC.value);
      }),

    // vpack: "center",
    child: Widget.Label({
      label: "Light",
    }),
  });
}
function Music() {
  return Widget.Box({
    vpack: "fill",
    hexpand: true,
    setup: (box) =>
      box.hook(MUSIC, () => {
        box.toggleClassName("popup", MUSIC.value);
      }),

    // vpack: "center",
    child: Widget.Label({
      label: "Music",
    }),
  });
}
function PanelChild() {
  return Widget.Box(
    {
      class_name: "player",
      css: "min-height:200px; min-width:400px;",
    },
    Widget.Box(
      {
        vexpand: true,
      },
      Music(),
      Light(),
    ),
  );
}

export const Panel = Widget.Window({
  name: "panel",
  visible: false,
  keymode: "exclusive",
  setup: (self) => {
    self.keybind("Escape", () => {
      App.closeWindow("panel");
    });
    self.keybind("m", () => {
      MUSIC.setValue(!MUSIC.value);
      App.closeWindow("panel");
      App.toggleWindow("player");
    });
    self.keybind("l", () => {
      LIGHT.setValue(!LIGHT.value);
    });
  },
  // child: Media(),
  child: PanelChild(),
});
