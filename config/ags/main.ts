import { Bar } from "Bar";
import { Launcher } from "Launcher";
import { NotificationPopups } from "NotificationPopups";
import { Panel } from "Panel";
import { Player } from "Player";

App.config({
  style: "./style.css",
  icons: "./assets/",
  windows: [Bar, Launcher, Player, Panel, NotificationPopups()],
});
