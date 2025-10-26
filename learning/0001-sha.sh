

echo "My secret data is here." > /tmp/mock.txt

shasum -a 256 /tmp/mock.txt

echo "Addition." >> /tmp/mock.txt

shasum -a 256 /tmp/mock.txt

rm /tmp/mock.txt
