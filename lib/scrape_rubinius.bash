RBX_BASE_URL="https://rubinius-releases-rubinius-com.s3.amazonaws.com"
MANIFEST="$RBX_BASE_URL/index.txt"

scrape_rubinius() {
  local filename pkg rbx

  curl -qsSLf "$MANIFEST" | grep '.tar.bz2$' | while IFS='' read -r pkg; do
    rbx="${pkg%.tar.bz2}"
    version="${rbx#rubinius-}"
    filename="${rbx/rubinius/rbx}"

    generate_definition "$version" "$filename" <<DEFINITION
require_llvm 3.5
install_package "openssl-1.0.2h" "https://www.openssl.org/source/openssl-1.0.2h.tar.gz#1d4007e53aad94a5b2002fe045ee7bb0b3d98f1a47f8b2bc851dcd1c74332919" mac_openssl --if has_broken_mac_openssl
install_package "${rbx}" "${RBX_BASE_URL}/${pkg}" rbx
DEFINITION
  done
}
