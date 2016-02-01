RBX_BASE_URL=https://rubinius-releases-rubinius-com.s3.amazonaws.com

scrape_rubinius() {
  local filename pkg rbx

  for pkg in $(curl "$RBX_BASE_URL/index.txt" 2>/dev/null | grep '.tar.bz2$'); do
    rbx="${pkg%.tar.bz2}"
    filename="${rbx/rubinius/rbx}"

    if ! file_exists "$filename"; then
      write_file "$filename" <<DEF
require_llvm 3.5
install_package "openssl-1.0.2e" "https://www.openssl.org/source/openssl-1.0.2e.tar.gz#e23ccafdb75cfcde782da0151731aa2185195ac745eea3846133f2e05c0e0bff" mac_openssl --if has_broken_mac_openssl
install_package "${rbx}" "https://rubinius-releases-rubinius-com.s3.amazonaws.com/${pkg}" rbx
DEF
    fi
  done
}
