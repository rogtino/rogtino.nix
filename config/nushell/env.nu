# Nushell Environment Config File
#
# version = 0.78.0

def create_left_prompt [] {
    mut home = ""
    try {
        if $nu.os-info.name == "windows" {
            $home = $env.USERPROFILE
        } else {
            $home = $env.HOME
        }
    }

    let dir = ([
        ($env.PWD | str substring 0..($home | str length) | str replace $home "~"),
        ($env.PWD | str substring ($home | str length)..)
    ] | str join)

    let path_segment = if (is-admin) {
        $"(ansi red_bold)($dir)"
    } else {
        $"(ansi green_bold)($dir)"
    }

    $path_segment
}

def create_right_prompt [] {
    let time_segment = ([
        (date now | format date '%m/%d/%Y %r')
    ] | str join)

    $time_segment
}

def --env yy [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = {|| create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
$env.NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

$env.VCPKG_ROOT = "/opt/vcpkg"
$env.VCPKG_DOWNLOADS = "/var/cache/vcpkg"
# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
if $nu.os-info.name == "windows" {
    $env.Path = ($env.Path | split row (char esep))
    $env.Path = ($env.Path | append '~/.local/bin' |append '~/.cargo/bin')
} else {
    $env.PATH = ($env.PATH | split row (char esep))
    $env.PATH = ($env.PATH | append '~/.local/bin' |prepend '~/.local/share/bob/nvim-bin'| append '~/.cargo/bin'| append '~/.local/share/solana/install/active_release/bin'|append '~/.rye/shims/' | append '~/.config/emacs/bin/' | append '/usr/bin/vendor_perl/')
    $env.PKG_CONFIG_PATH = "/usr/lib/pkgconfig:/usr/local/lib/pkgconfig"
    $env.LD_LIBRARY_PATH = "/usr/lib:/usr/local/lib/"
    $env.PATH = ($env.PATH | prepend '~/.nix-profile/bin/')
    $env.PATH = ($env.PATH | prepend '~/go/bin/')
    $env.PATH = ($env.PATH | prepend '~/go/bin/')
    $env.PNPM_HOME = $"($env.HOME)/.local/share/pnpm"
    $env.PATH = ($env.PATH | prepend $env.PNPM_HOME )

}

$env.EDITOR = "nvim"
$env.GOPROXY = "https://goproxy.cn,direct"
$env.GO111MODULE = "on"
$env.RUSTUP_DIST_SERVER = "https://rsproxy.cn"
$env.RUSTUP_UPDATE_ROOT = "https://rsproxy.cn/rustup"
$env.MANPAGER = "sh -c 'col -bx | bat -l man -p'"
$env.MANROFFOPT = "-c"
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
zoxide init nushell | save -f ~/.zoxide.nu
