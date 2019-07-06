#!/usr/bin/expect

# sudo apt-get install expect

set PACKAGES [lindex $argv 0]

# The installation time should be less than 1 hour
set timeout 3600

spawn bash -c "LC_ALL=C chroot . /bin/bash"
expect ":/# "  { send "apt-get install -y ${PACKAGES}\r" }
expect ":/# "  { send "exit\r" }
