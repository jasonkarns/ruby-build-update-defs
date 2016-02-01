RBX_BASE_URL=https://rubinius-releases-rubinius-com.s3.amazonaws.com

scrape_rubinius() {
  local filename pkg rbx

  for pkg in $(curl "$RBX_BASE_URL/index.txt" 2>/dev/null | grep '.tar.bz2$'); do
    rbx="${pkg%.tar.bz2}"
    filename="${rbx/rubinius/rbx}"

    if ! file_exists "$filename"; then
      write_file "$filename" <<DEF
require_llvm 3.5
install_package "openssl-1.0.2f" "https://www.openssl.org/source/openssl-1.0.2f.tar.gz#932b4ee4def2b434f85435d9e3e19ca8ba99ce9a065a61524b429a9d5e9b2e9c" mac_openssl --if has_broken_mac_openssl
install_package "${rbx}" "https://rubinius-releases-rubinius-com.s3.amazonaws.com/${pkg}" rbx
DEF
    fi
  done
}
