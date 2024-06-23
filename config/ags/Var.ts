import GLib from "gi://GLib";
export const LOGO = Variable(GLib.get_os_info("LOGO")!);

export const MUSIC = Variable(false);
export let LIGHT = Variable(false);
export const DATE = Variable("", {
  poll: [1000, 'date "+%H:%M"'],
});
export const CPU = Variable("", {
  poll: [
    2000,
    () => {
      return Utils.exec(
        `sh -c "grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}'"`,
      );
    },
  ],
});
export const MEM = Variable("", {
  poll: [
    2000,
    () => {
      return Utils.exec(`sh -c "free |grep 'Mem:'  |awk '{print $3*100/$2}'"`);
    },
  ],
});
export const DOWN = Variable("", {
  poll: [
    2000,
    () => {
      return Utils.exec(`sh -c "ifstat -p |grep wlan0 |awk '{print $6}'"`);
    },
  ],
});
export const UP = Variable("", {
  poll: [
    2000,
    () => {
      return Utils.exec(`sh -c "ifstat -p |grep wlan0 |awk '{print $8}'"`);
    },
  ],
});
