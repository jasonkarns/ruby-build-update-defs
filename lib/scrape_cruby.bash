MANIFEST=https://cache.ruby-lang.org/pub/ruby/index.txt

scrape_cruby() {
  local filename line package release sha url version

  curl -qsSLf "$MANIFEST" | grep '.tar.bz2' |\
  while IFS='' read -r line || [[ -n "$line" ]]; do
    read -ra release <<<"$line"

    package="${release[0]}"
    url="${release[1]}"
    sha="${release[3]}"

    version="${package#ruby-}"
    filename="$version"

    generate_definition "$version" "$filename" <<DEFINITION
$OPENSSL
install_package "$package" "$url#$sha" ldflags_dirs standard verify_openssl
DEFINITION

  done
}
