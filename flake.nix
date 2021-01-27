{
  description = "rdr";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/release-20.09";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          devShell = pkgs.mkShell {
            buildInputs = [ pkgs.nodejs-14_x pkgs.yarn pkgs.yarn2nix ];
          };
          defaultPackage = pkgs.mkYarnPackage
            {
              name = "rdr";
              src = ./.;
              packageJSON = ./package.json;
              yarnLock = ./yarn.lock;
              postBuild = ''
                ls -lha .
                yarn tsc
                (cd ./deps/rdr && yarn tsc)
                chmod a+x ./deps/rdr/dist/*
                chmod a+x ./deps/rdr/dist/*
                ls -lha ./deps/rdr/dist/
              '';
              # NOTE: this is optional and generated dynamically if omitted
              # yarnNix = ./yarn.nix;

            };
        }
      );
}
