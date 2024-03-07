{
  description = "Useful scripts that do small things";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }: let
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages."${system}";

        buildScript = name: buildInputs: let
          src = builtins.readFile ./scripts/${name}.sh;
          script = (pkgs.writeScriptBin name src).overrideAttrs(old: {
            buildCommand = "${old.buildCommand}\n patchShebangs $out";
          });
        in pkgs.symlinkJoin {
          inherit name;
          paths = [ script ] ++ buildInputs;
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = "wrapProgram $out/bin/${name} --prefix PATH : $out/bin";
        };
      in {
        packages = builtins.listToAttrs (
          map
            ({ name, buildInputs }: {
              inherit name;
              value = buildScript name buildInputs;
            })
            (pkgs.lib.mapAttrsToList (name: value: { inherit name; buildInputs = value; }) {

              fix_pen = with pkgs; [ libinput ydotool ];

              change_timer = [ ];

            })
          );
      }
    );
}
