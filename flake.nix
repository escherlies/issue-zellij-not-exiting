{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, ... }@inputs:
    with inputs;
    let

      # System types to support.
      supportedSystems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Nixpkgs instantiated for supported system types.
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });

    in
    {
      # NixOS Configs
      nixosConfigurations = {
      };

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
          buildInputs = with pkgs; [
            zellij
            bun
            htop
            just

          ];
        in
        {
          default = pkgs.mkShell {
            buildInputs = buildInputs;
            shellHook = ''
              zellij --layout layout.kdl
              echo "Closed zellij session"
              echo ""
              echo ""
              echo "Curling recently spawned servers:"
              echo ""
              echo ""
              ./echo.sh
            '';
          };
        }
      );

    };
}
