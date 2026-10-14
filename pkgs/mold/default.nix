{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  zlib,
  zstd,
  nix-update-script,
  testers,
  versionCheckHook,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "mold";
  version = "3.0.0";

  src = fetchFromGitHub {
    owner = "rui314";
    repo = "mold";
    tag = "v${finalAttrs.version}";
    hash = "sha256-XigEJb7wv46XuzT9s83pllLxCqN0Va3ZN7P/Ch9qXsY=";
  };

  # Vendors the crates.io and git (mimalloc_rust) dependencies.
  cargoHash = "sha256-DgCFmTz+qulwXu1Oax8gBnc/6HIT6TlY8+xzBRGFvu0=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    zlib
    zstd
  ];

  env = {
    # Link the system zstd instead of the bundled one.
    ZSTD_SYS_USE_PKG_CONFIG = "1";
    # Used by `mold -run` as the fallback location of mold-wrapper.so.
    MOLD_LIBDIR = "${placeholder "out"}/lib";
  };

  # cargo builds the release artifacts; install-mold.sh installs them,
  # ld.mold and ld symlinks, the man page and the -run preload library.
  dontCargoInstall = true;
  installPhase = ''
    runHook preInstall

    # cargoBuildHook passes --target, so artifacts live under target/<triple>/.
    CARGO_TARGET_DIR="$PWD/target/${stdenv.hostPlatform.rust.rustcTargetSpec}" \
      PREFIX=$out ./install-mold.sh

    runHook postInstall
  '';

  # The test suite needs gcc, clang and binutils tools and takes a long time.
  doCheck = false;

  doInstallCheck = true;
  nativeInstallCheckInputs = [ versionCheckHook ];

  passthru = {
    updateScript = nix-update-script { };
    tests.version = testers.testVersion {
      package = finalAttrs.finalPackage;
      command = "mold --version";
    };
  };

  meta = {
    description = "Faster drop-in replacement for existing Unix linkers";
    longDescription = ''
      mold is a faster drop-in replacement for existing Unix linkers. It is
      several times faster than the LLVM lld linker. mold 3.x is a rewrite
      of mold in Rust, and is intended as a drop-in replacement for 2.42.1.
    '';
    homepage = "https://github.com/rui314/mold";
    changelog = "https://github.com/rui314/mold/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    mainProgram = "mold";
  };
})
