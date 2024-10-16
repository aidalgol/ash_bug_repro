{
  description = "Ash bug minimal reproduction";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    make-shell.url = "github:nicknovitski/make-shell";
    process-compose-flake.url = "github:Platonic-Systems/process-compose-flake";
    services-flake.url = "github:juspay/services-flake";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.make-shell.flakeModules.default
        inputs.process-compose-flake.flakeModule
      ];
      systems = ["x86_64-linux"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        make-shells.default = {
          packages = [
            pkgs.just
            pkgs.elixir_1_17
            pkgs.elixir-ls
            pkgs.inotify-tools
          ];
        };

        process-compose."database" = {
          imports = [
            inputs.services-flake.processComposeModules.default
          ];

          services.postgres."postgres1" = {
            enable = true;
            package = pkgs.postgresql_16;
            listen_addresses = "127.0.0.1";
            initialScript.before = ''
              CREATE ROLE postgres PASSWORD 'postgres' LOGIN SUPERUSER;
            '';
            settings = {
              log_destination = "stderr";
              logging_collector = "true";
            };
          };
        };

        formatter = pkgs.alejandra;
      };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.
      };
    };
}
