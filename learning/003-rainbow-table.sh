#!/bin/bash
# Title: Salting vs. Unsalted Hash Demonstration
# Environment: Designed for Kali Linux (or macOS/Unix with shasum and openssl)

# --- Configuration ---
TEST_PASSWORD="password123"
HASH_ALGO="-a 256" # Use SHA-256 as the cryptographic hash function

echo "--- 1. UNSALTED HASH (VULNERABLE TO RAINBOW TABLES) ---"
# Hashing a fixed input always produces the same output.

# Hash 1
HASH1_UNSALTED=$(echo -n "$TEST_PASSWORD" | shasum $HASH_ALGO | awk '{print $1}')

# Hash 2
HASH2_UNSALTED=$(echo -n "$TEST_PASSWORD" | shasum $HASH_ALGO | awk '{print $1}')

echo "Password: $TEST_PASSWORD"
echo "Hash 1: $HASH1_UNSALTED"
echo "Hash 2: $HASH2_UNSALTED"
echo "Observation: Hashes are identical. A rainbow table only needs to store this single hash value to crack this password for all users."

echo ""

echo "--- 2. SALTED HASH STORAGE (RAINBOW TABLE DEFENSE) ---"
# Salting adds random data (the salt) to the password before hashing.

# Step 2a: Store the Hash (System Initialization)
# Generate a unique, random salt (stored openly alongside the hash).
SALT_A=$(openssl rand -base64 16 | tr -d '\n')
echo "Stored Salt A: $SALT_A"

# Combine password + salt, then hash the combination (HASH_A_STORED)
INPUT_A="${TEST_PASSWORD}${SALT_A}"
HASH_A_STORED=$(echo -n "$INPUT_A" | shasum $HASH_ALGO | awk '{print $1}')
echo "Stored Hash A: $HASH_A_STORED"

# Step 2b: Simulate a second attempt/user with a NEW random salt.
SALT_B=$(openssl rand -base64 16 | tr -d '\n')
INPUT_B="${TEST_PASSWORD}${SALT_B}"
HASH_B_NEW=$(echo -n "$INPUT_B" | shasum $HASH_ALGO | awk '{print $1}')

echo "New Random Salt B: $SALT_B"
echo "New Hash B: $HASH_B_NEW"

echo "Observation: HASH A and HASH B are unique. An attacker cannot use a single precomputed table for both."

echo ""

echo "--- 3. VERIFICATION (AUTHENTICATION SIMULATION) ---"
# During login, the system retrieves the stored salt (SALT_A) and applies it to the user input.

# System retrieves the original stored salt (SALT_A) and applies it to the input password.
INPUT_VERIFY="${TEST_PASSWORD}${SALT_A}"
HASH_VERIFIED=$(echo -n "$INPUT_VERIFY" | shasum $HASH_ALGO | awk '{print $1}')

echo "Verification Hash (Input + Reused Salt A): $HASH_VERIFIED"
echo "Original Stored Hash A: $HASH_A_STORED"

if [ "$HASH_VERIFIED" == "$HASH_A_STORED" ]; then 
    echo "Result: MATCH! Authentication successful because the original salt was reused."
fi
