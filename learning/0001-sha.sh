

# The shasum command is used to compute and check message digests.
# The -a option, for algorithm, specifies the digest algorithm to use.
# In this case, 256 stands for SHA-256.

echo "My secret data is here." > /tmp/mock.txt

shasum -a 256 /tmp/mock.txt

echo "Addition." >> /tmp/mock.txt

shasum -a 256 /tmp/mock.txt

rm /tmp/mock.txt
