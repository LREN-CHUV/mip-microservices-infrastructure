#!/bin/sh

# Create a password hash from your plaintext password

echo "Enter the password to hash"
echo

python -c "import crypt, getpass, random, string; \
    print crypt.crypt(getpass.getpass(), '\$6\$%s\$' % \"\".join(random.sample(string.letters+string.digits, 8)))"
