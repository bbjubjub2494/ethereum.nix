{
  fetchFromGitHub,
  pkgs,
  targets ? ["nimbus_beacon_node" "nimbus_validator_client" "gnosis-build" "gnosis-vc-build"],
  stableSystems ? ["x86_64-linux" "aarch64-linux"],
}: let
  version = "25.9.2";
  src = fetchFromGitHub {
    owner = "status-im";
    repo = "nimbus-eth2";
    rev = "v${version}";
    hash = "sha256-TriDSV36oUd11m8mS6XruGXaoZuP4hx8a+Csp/qxKRw=";
    fetchSubmodules = true;
  };
in
  import "${src}/nix" {inherit pkgs targets stableSystems;}
