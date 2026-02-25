 {
    description = "Ollama";

    inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    in {
      packages.${system}.default =
        (pkgs.ollama.override { acceleration = null; }).overrideAttrs (_: {
          version = "local";
          src = self;
          vendorHash = "sha256-dGMx8ltvlqhdzAfvvE5EliTcTNxGnzwcyLQTP71fGwA=";
          subPackages = [ "." ];
        });
    };
  }
