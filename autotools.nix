pkgs: attrs:
  with pkgs;
  let defaultAttrs = {
    builder = "${bash}/bin/bash";
    args = [ ./setup.sh ];
    baseInputs = [ gnutar gzip gcc binutils-unwrapped gnumake coreutils gawk gnused gnugrep findutils patchelf ];
    buildInputs = [ clang ];
    gcc = clang;
    binutils = clang.bintools.bintools_bin;
    system = builtins.currentSystem;
  };
  in
  derivation (defaultAttrs // attrs)
