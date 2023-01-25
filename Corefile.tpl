.:53 {
  rewrite continue {
    name regex (^.[^.]+)(\.$) {1}.service.consul answer auto
  }
  fanout . {{ env "CONSUL_ADDRESS" }}:8600 8.8.8.8
}
