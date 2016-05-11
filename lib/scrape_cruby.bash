MANIFEST=https://cache.ruby-lang.org/pub/ruby/index.txt

scrape_cruby() {
  local line release version filename url sha

  curl -qsSLf "$MANIFEST" | grep '.tar.bz2' |\
  while IFS='' read -r line || [[ -n "$line" ]]; do
    read -ra release <<<"$line"

    version="${release[0]}"
    filename="${version#ruby-}"
    url="${release[1]}"
    sha="${release[3]}"

    if ! file_exists "$filename" && is_recent_release "$filename"; then
      write_file "$filename" <<DEF
install_package "openssl-1.0.2h" "https://www.openssl.org/source/openssl-1.0.2h.tar.gz#1d4007e53aad94a5b2002fe045ee7bb0b3d98f1a47f8b2bc851dcd1c74332919" mac_openssl --if has_broken_mac_openssl
install_package "$version" "$url#$sha" ldflags_dirs standard verify_openssl
DEF
    fi
  done
}
