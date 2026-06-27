{
  description = "1 Billion Row Challenge (1brc) development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            jdk21
            python3
            hyperfine
            coreutils
            gnugrep
          ];

          shellHook = ''
            echo "1brc dev shell"
            echo "Java: $(java -version 2>&1 | head -n1)"
            echo "Commands: ./scripts/generate.sh [rows]  |  ./scripts/run.sh"
          '';
        };
      });
}
