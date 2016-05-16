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
$OPENSSL
install_package "${package}" "${RBX_BASE_URL}/${release}" rbx
DEFINITION
  done
}
