# ssh-keygen: A tool for creating and managing authentication keys.
# -t rsa: Specifies the type of key to create, in this case, RSA.
# -b 4096: Specifies the number of bits in the key (4096 for a strong key).
# -f id_rsa: Specifies the filename for the new key.
# -N "passphrase": Provides the passphrase for the key.
ssh-keygen -t rsa -b 4096 -f id_rsa -N "passphrase"

cat id_rsa

echo ""
echo "-----BEGIN OPENSSH PUBLIC KEY-----"

cat id_rsa.pub

echo "-----END OPENSSH PUBLIC KEY-----"

rm id_rsa

rm id_rsa.pub
