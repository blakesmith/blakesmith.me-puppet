class irssi {
  package { ["irssi", "tmux"]:
    ensure => latest,
  }
}
