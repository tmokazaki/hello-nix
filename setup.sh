set -e
unset PATH
for p in $baseInputs $buildInputs; do
  export PATH="$p/bin${PATH:+:}$PATH"
done

if [ -d $binutils ]; then
  PATH="$binutils/bin${PATH:+:}$PATH"
fi

function unpackPhase() {
  echo "unpacking..."
  tar -xzf $src

  for d in *; do
    if [ -d "$d" ]; then
      cd "$d"
      break
    fi
  done
}

function configurePhase() {
  echo "configure..."
  ./configure --prefix=$out
}

function buildPhase() {
  echo "make..."
  make
}

function installPhase() {
  echo "make install..."
  make install
}

function fixupPhase() {
  find $out -type f -exec patchelf --shrink-rpath '{}' \; -exec strip '{}' \; 2>/dev/null
}

function genericBuild() {
  unpackPhase
  configurePhase
  buildPhase
  installPhase
  fixupPhase
}

genericBuild
