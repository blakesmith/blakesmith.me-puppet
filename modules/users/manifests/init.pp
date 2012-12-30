class users {
  add_user { 'blake':
    name    => "Blake Smith",
    uid      => "2000",
    password => '$1$abc123', # generated with 'openssl passwd -1'
    shell => "/bin/bash",
    groups => ['sudo', 'blake'],
    sshkeytype => "ssh-rsa",
    sshkey => "AAAAB3NzaC1yc2EAAAABIwAAAQEA+8pDaKB8oIcKE1RjdqYVQGIcTNU87cKB5JFLgf56qNPrYddaKa6ERUp6RVzf8a3J21p7T102r4ZQeM7IDa+8Bq0Rft45NX7zqmPi/IF058geUv5Jo3S7sYs96YSQG2ACsrJS9aAfMmRSFyBut4XDMe26Zql4aDntchlCFetRirRq0Bp3BO8KNUimu8DDCbdFstQtKJVw/fOvirKPMjO0hQS1n3CqRswRn/Pc6/og7yJ2wDSvrrLulNnZEbznNKXPY2Ar9BUksdxK2JRQxeM8y+J/0CVD3F+KPKMsIE1mosCeaRSYNjkSBhbURKSZKi0ODMx3HenWXU1ufG+oByLsfw==" # publickey from ~/.ssh/id-rsa.pub
  }
  
  add_user { 'deploy':
    name    => "Deploy User",
    uid      => "2001",
    password => '$1$abc123', # generated with 'openssl passwd -1'
    shell => "/bin/bash",
    groups => ['sudo', 'www-data'],
    sshkeytype => "ssh-rsa",
    sshkey => "AAAAB3NzaC1yc2EAAAABIwAAAQEA+8pDaKB8oIcKE1RjdqYVQGIcTNU87cKB5JFLgf56qNPrYddaKa6ERUp6RVzf8a3J21p7T102r4ZQeM7IDa+8Bq0Rft45NX7zqmPi/IF058geUv5Jo3S7sYs96YSQG2ACsrJS9aAfMmRSFyBut4XDMe26Zql4aDntchlCFetRirRq0Bp3BO8KNUimu8DDCbdFstQtKJVw/fOvirKPMjO0hQS1n3CqRswRn/Pc6/og7yJ2wDSvrrLulNnZEbznNKXPY2Ar9BUksdxK2JRQxeM8y+J/0CVD3F+KPKMsIE1mosCeaRSYNjkSBhbURKSZKi0ODMx3HenWXU1ufG+oByLsfw==" # publickey from ~/.ssh/id-rsa.pub
  }
}
