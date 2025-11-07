#!/bin/bash
#
# SCRIPT: integrity_check.sh
#
# This script demonstrates the concept of hashing for file integrity.
# We will use 'sha256sum', the standard GNU/Linux (and Kali) utility 
# for calculating a SHA-256 hash.

# Define a variable for our test file to make it easy to reuse
TEMP_FILE="/tmp/mock.txt"

echo "---"
echo "Step 1: Creating original file at $TEMP_FILE"
echo "My secret data is here." > $TEMP_FILE

# Calculate and display the original hash
echo "Step 2: Calculating original hash (the 'known good' value):"
sha256sum $TEMP_FILE

# Modify the file, which will break its integrity
echo "---"
echo "Step 3: Modifying the file by appending new data..."
echo "Addition." >> $TEMP_FILE

# Calculate and display the new hash
echo "Step 4: Calculating hash of the modified file:"
sha256sum $TEMP_FILE

# Clean up the temporary file
echo "---"
echo "Step 5: Cleaning up $TEMP_FILE"
rm $TEMP_FILE

echo "---"
echo "Done. Notice the two hashes are completely different."
echo "This proves the file's integrity was lost after modification."
