RBX_BASE_URL=https://rubinius-releases-rubinius-com.s3.amazonaws.com

scrape_rubinius() {
  local filename pkg rbx

  for pkg in $(curl "$RBX_BASE_URL/index.txt" 2>/dev/null | grep '.tar.bz2$'); do
    rbx="${pkg%.tar.bz2}"
    filename="${rbx/rubinius/rbx}"

    if ! file_exists "$filename"; then
      write_file "$filename" <<DEF
require_llvm 3.5
install_package "openssl-1.0.2g" "https://www.openssl.org/source/openssl-1.0.2g.tar.gz#b784b1b3907ce39abf4098702dade6365522a253ad1552e267a9a0e89594aa33" mac_openssl --if has_broken_mac_openssl
install_package "${rbx}" "https://rubinius-releases-rubinius-com.s3.amazonaws.com/${pkg}" rbx
DEF
    fi
  done
}
