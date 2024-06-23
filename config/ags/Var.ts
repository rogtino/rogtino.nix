import GLib from "gi://GLib";
export const LOGO = Variable(GLib.get_os_info("LOGO")!);

export const MUSIC = Variable(false);
export let LIGHT = Variable(false);
export const DATE = Variable("", {
  poll: [1000, 'date "+%H:%M"'],
});
