{
  description = "A Plymouth theme with a spinning fox from Minecraft as a throbber";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      defaultPackage.${system} = pkgs.stdenv.mkDerivation {
        pname = "plymouth-theme-foxspin";
        version = "0.1.0";
        src = ./foxspin;
        dontBuild = true;
        installPhase = /* bash */ ''
          mkdir -p $out/share/plymouth/themes/foxspin
          cp * $out/share/plymouth/themes/foxspin
          find $out/share/plymouth/themes/ -name \*.plymouth -exec sed -i "s@\/usr\/@$out\/@" {} \;
        '';
      };
    };
}
