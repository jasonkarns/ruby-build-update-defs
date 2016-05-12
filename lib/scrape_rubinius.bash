RBX_BASE_URL="https://rubinius-releases-rubinius-com.s3.amazonaws.com"
MANIFEST="$RBX_BASE_URL/index.txt"

scrape_rubinius() {
  local filename package release version

  curl -qsSLf "$MANIFEST" | grep '.tar.bz2$' | while IFS='' read -r release; do
    package="${release%.tar.bz2}"
    version="${package#rubinius-}"
    filename="rbx-${version}"

    generate_definition "$version" "$filename" <<DEFINITION
require_llvm 3.5
install_package "openssl-1.0.2h" "https://www.openssl.org/source/openssl-1.0.2h.tar.gz#1d4007e53aad94a5b2002fe045ee7bb0b3d98f1a47f8b2bc851dcd1c74332919" mac_openssl --if has_broken_mac_openssl
install_package "${package}" "${RBX_BASE_URL}/${release}" rbx
DEFINITION
  done
}
