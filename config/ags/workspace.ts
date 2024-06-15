function range(length: number, start = 1) {
  return Array.from({ length }, (_, i) => i + start);
}
const hyprland = await Service.import("hyprland");
const WINDOW_NAME = "workspace";
// there needs to be only one instance
export const workspace = Widget.Window({
  name: WINDOW_NAME,
  visible: true,
  // keymode: "exclusive",
  anchor: ["top", "left", "right"],
  child: Widget.Box({
    children: range(7).map((i) =>
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
      box.hook(hyprland.active.workspace, () =>
        box.children.map((btn) => {
          btn.visible = hyprland.workspaces.some(
            (ws) => ws.id === btn.attribute,
          );
        }),
      );
    },
  }),
});
