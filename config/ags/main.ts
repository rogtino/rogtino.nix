import { Bar } from "Bar";
import { Launcher } from "Launcher";
import { Player } from "Player";
import { Panel } from "Panel";
import { NotificationPopups } from "NotificationPopups";

App.config({
  style: "./style.css",
  icons: "./assets/",
  windows: [Bar, Launcher, Player, Panel, NotificationPopups()],
});
