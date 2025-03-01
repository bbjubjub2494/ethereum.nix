{
  clang,
  cmake,
  fetchFromGitHub,
  fetchurl,
  lib,
  llvmPackages,
  openssl,
  sqlite,
  rust-jemalloc-sys,
  protobuf,
  rustPlatform,
  postgresql,
}:
  rustPlatform.buildRustPackage rec {
    pname = "grandine";
    version = "1.0.0";

    src = fetchFromGitHub {
      owner = "grandinetech";
      repo = pname;
      rev = version;
      hash = "sha256-rF0s16ic91GF8xfSMX08+tcB7LM2P5zZvYRrfsMJuU8=";
    };

        useFetchCargoVendor = true;
    cargoHash = "sha256-dwb1Tqqx7EoSKOW765HfldBJwE24mW2yTG6Z4XgGgXc=";

    enableParallelBuilding = true;

    cargoBuildFlags = ["--package grandine"];

    nativeBuildInputs = [cmake clang];
    buildInputs = [openssl protobuf sqlite rust-jemalloc-sys];

    buildNoDefaultFeatures = true;
    buildFeatures = ["modern" "slasher-lmdb"];

    # Needed to get openssl-sys to use pkg-config.
    OPENSSL_NO_VENDOR = 1;
    OPENSSL_LIB_DIR = "${lib.getLib openssl}/lib";
    OPENSSL_DIR = "${lib.getDev openssl}";

    # Needed to get prost-build to use protobuf
    PROTOC = "${protobuf}/bin/protoc";

    # Needed by libmdx
    LIBCLANG_PATH = "${llvmPackages.libclang.lib}/lib";

    # This is needed by the unit tests.
    FORK_NAME = "capella";

    cargoTestFlags = [
      "--workspace"
    ];

    nativeCheckInputs = [
      postgresql
    ];

    checkFeatures = [];

    # All of these tests require network access
    checkFlags = [
    ];

    meta = {
      description = "High performance Ethereum consensus client";
      homepage = "https://github.com/grandinetech/grandine";
      mainProgram = "grandine";
      platforms = ["x86_64-linux"];
    };
  }
