#!/usr/bin/env python
import os
import sys
from dataclasses import dataclass
from typing import Optional


@dataclass
class LinkItem:
    name: str
    source: str
    des: str


todo: list[LinkItem] = []

roaming = ["nushell"]
config = ["nvim"]


def get_des_path(name: str) -> Optional[str]:
    match sys.platform:
        case "linux":
            return os.path.join(os.path.expanduser("~/.config"), name)
        case "win32":
            local_dir = os.path.join(os.environ["USERPROFILE"], "AppData", "Local")
            roaming_dir = os.path.join(os.environ["USERPROFILE"], "AppData", "Roaming")
            roaming_list = ["nushell"]
            local_list = ["nvim"]
            if name in roaming_list:
                return os.path.join(roaming_dir, name)
            elif name in local_list:
                return os.path.join(local_dir, name)
            else:
                return None
        case _:
            raise OSError("your os is not currently supported")


def init():
    for dir in os.listdir("xdg"):
        s = os.path.abspath(os.path.join("xdg", dir))
        d = get_des_path(dir)
        if d is None:
            continue
        todo.append(LinkItem(name=dir, source=s, des=d))


def link():
    try:
        for item in todo:
            print(f"symlink {item.source} to {item.des}")
            os.symlink(item.source, item.des)
    except OSError as e:
        print(f"create symlink error {e}")


def clean():
    for item in todo:
        folder = item.des
        if os.path.exists(folder):
            print(f"deleting {folder}")
            os.remove(folder)


if __name__ == "__main__":
    # populate todo list
    init()

    if len(sys.argv) == 1:
        link()
    elif len(sys.argv) == 2:
        if sys.argv[1] == "clean":
            clean()
        else:
            print(f"{sys.argv[1]} not supported")
    else:
        print("too many arguments")
