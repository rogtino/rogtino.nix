return {
  s(
    'devs',
    fmt(
      [[
            {{
              inputs = {{
                nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
                flake-utils.url = "github:numtide/flake-utils";
              }};

              outputs = {{
                self,
                nixpkgs,
                flake-utils,
                ...
              }}:
                flake-utils.lib.eachDefaultSystem (system: let
                  pkgs = nixpkgs.legacyPackages.${{system}};
                in {{
                  devShell = with pkgs;
                    mkShell {{
                      buildInputs =
                        [
                        {}
                        ];
                    }};
                }});
            }}

            ]],
      ins_generate()
    )
  ),
  s(
    'guidevs',
    fmt(
      [[
            {{
      inputs = {{
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        flake-utils.url = "github:numtide/flake-utils";
      }};

      outputs = {{
        self,
        nixpkgs,
        flake-utils,
        ...
      }}:
        flake-utils.lib.eachDefaultSystem (system: let
          pkgs = nixpkgs.legacyPackages.${{system}};
          defaultGui = with pkgs;
            [
              wayland
              libxkbcommon
              libGL
              # wayland
              # vulkan-loader
            ]
            ++ (with xorg; [
              libXcursor
              libXrandr
              libXi
              libX11
            ]);
        in {{
          devShell = with pkgs;
            mkShell rec {{
              buildInputs = defaultGui ++ with pkgs;[{}];
              libPath = with pkgs;
                lib.makeLibraryPath defaultGui;
              LD_LIBRARY_PATH = libPath;
            }};
        }});
    }}

        ]],
      ins_generate()
    )
  ),
}
