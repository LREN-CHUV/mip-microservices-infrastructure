#!/usr/bin/env bash

#
# Grant access to the configuration and passwords to MIP operations team
#

echo "Grant access to Ludovic CLAUDE, CHUV"
gpg_key=E6A069F9
gpg --recv-keys --keyserver hkp://keys.gnupg.net $gpg_key
gpg --sign-key $gpg_key
git-crypt add-gpg-user $gpg_key

echo "Grant access to Mirco NASUTI, CHUV"
gpg_key=D7F848B3
gpg --recv-keys --keyserver hkp://keys.gnupg.net $gpg_key
gpg --sign-key $gpg_key
git-crypt add-gpg-user $gpg_key

git push origin master
