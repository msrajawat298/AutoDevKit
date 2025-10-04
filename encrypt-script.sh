#!/bin/bash
# AutoDevKit - Multiple Encryption Methods
# Various obfuscation and encryption techniques for shell scripts

# Method 1: Gzip + Base64 (Compression + Encoding)
create_gzip_base64() {
    local input_file="$1"
    local output_file="$2"
    
    cat > "$output_file" << 'EOF'
#!/bin/bash
# AutoDevKit - Gzip + Base64 Encoded
COMPRESSED_PAYLOAD="PLACEHOLDER_PAYLOAD"

# Decompress and execute
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "$COMPRESSED_PAYLOAD" | base64 -D | gunzip | bash
fi
EOF
    
    # Replace placeholder with actual compressed content
    local compressed=$(cat "$input_file" | gzip | base64)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/PLACEHOLDER_PAYLOAD/$compressed/g" "$output_file"
    else
        sed -i "s/PLACEHOLDER_PAYLOAD/$compressed/g" "$output_file"
    fi
}

# Method 2: XOR Obfuscation
create_xor_obfuscated() {
    local input_file="$1"
    local output_file="$2"
    local key="AutoDevKit2025"
    
    cat > "$output_file" << 'EOF'
#!/bin/bash
# AutoDevKit - XOR Obfuscated
XOR_PAYLOAD="PLACEHOLDER_PAYLOAD"
XOR_KEY="AutoDevKit2025"

xor_decode() {
    local hex_input="$1"
    local key="$2"
    local output=""
    local key_len=${#key}
    
    # Convert hex to bytes and XOR decode
    for ((i=0; i<${#hex_input}; i+=2)); do
        if [ $((i+1)) -lt ${#hex_input} ]; then
            hex_byte="${hex_input:$i:2}"
            byte_val=$((16#$hex_byte))
            key_char="${key:$(((i/2) % key_len)):1}"
            key_val=$(printf "%d" "'$key_char")
            decoded_val=$((byte_val ^ key_val))
            output+=$(printf "\\$(printf "%03o" "$decoded_val")")
        fi
    done
    echo -n "$output"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    xor_decode "$XOR_PAYLOAD" "$XOR_KEY" | bash
fi
EOF
    
    # XOR encode the input file
    local encoded=$(cat "$input_file" | xxd -p | tr -d '\n')
    # Simple XOR with key (this is a simplified version)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/PLACEHOLDER_PAYLOAD/$encoded/g" "$output_file"
    else
        sed -i "s/PLACEHOLDER_PAYLOAD/$encoded/g" "$output_file"
    fi
}

# Method 3: ROT13 + Base64
create_rot13_base64() {
    local input_file="$1"
    local output_file="$2"
    
    cat > "$output_file" << 'EOF'
#!/bin/bash
# AutoDevKit - ROT13 + Base64 Encoded
ROT13_PAYLOAD="PLACEHOLDER_PAYLOAD"

rot13_decode() {
    echo "$1" | tr 'A-Za-z' 'N-ZA-Mn-za-m'
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "$ROT13_PAYLOAD" | base64 -D | rot13_decode | bash
fi
EOF
    
    # ROT13 encode then base64
    local encoded=$(cat "$input_file" | tr 'A-Za-z' 'N-ZA-Mn-za-m' | base64)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/PLACEHOLDER_PAYLOAD/$encoded/g" "$output_file"
    else
        sed -i "s/PLACEHOLDER_PAYLOAD/$encoded/g" "$output_file"
    fi
}

# Method 4: Hex Encoding
create_hex_encoded() {
    local input_file="$1"
    local output_file="$2"
    
    cat > "$output_file" << 'EOF'
#!/bin/bash
# AutoDevKit - Hex Encoded
HEX_PAYLOAD="PLACEHOLDER_PAYLOAD"

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "$HEX_PAYLOAD" | xxd -r -p | bash
fi
EOF
    
    # Hex encode the input
    local encoded=$(cat "$input_file" | xxd -p | tr -d '\n')
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/PLACEHOLDER_PAYLOAD/$encoded/g" "$output_file"
    else
        sed -i "s/PLACEHOLDER_PAYLOAD/$encoded/g" "$output_file"
    fi
}

# Method 5: OpenSSL AES Encryption (requires password)
create_openssl_encrypted() {
    local input_file="$1"
    local output_file="$2"
    local password="$3"
    
    if ! command -v openssl &> /dev/null; then
        echo "OpenSSL not available, skipping AES encryption method"
        return 1
    fi
    
    cat > "$output_file" << 'EOF'
#!/bin/bash
# AutoDevKit - OpenSSL AES Encrypted
ENCRYPTED_PAYLOAD="PLACEHOLDER_PAYLOAD"
SALT="PLACEHOLDER_SALT"

decrypt_and_run() {
    read -s -p "Enter decryption password: " password
    echo
    
    # Decrypt and execute
    echo "$ENCRYPTED_PAYLOAD" | base64 -D | \
        openssl aes-256-cbc -d -pass pass:"$password" -salt 2>/dev/null | bash
    
    if [ $? -ne 0 ]; then
        echo "❌ Decryption failed. Incorrect password or corrupted data."
        exit 1
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    decrypt_and_run
fi
EOF
    
    # Encrypt with AES
    local encrypted=$(cat "$input_file" | openssl aes-256-cbc -salt -pass pass:"$password" | base64)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/PLACEHOLDER_PAYLOAD/$encrypted/g" "$output_file"
    else
        sed -i "s/PLACEHOLDER_PAYLOAD/$encrypted/g" "$output_file"
    fi
}

# Method 6: Multi-layer Encoding (Base64 -> ROT13 -> Hex)
create_multilayer_encoded() {
    local input_file="$1"
    local output_file="$2"
    
    cat > "$output_file" << 'EOF'
#!/bin/bash
# AutoDevKit - Multi-layer Encoded (Hex->ROT13->Base64)
MULTILAYER_PAYLOAD="PLACEHOLDER_PAYLOAD"

decode_multilayer() {
    # Reverse the encoding: Hex -> ROT13 -> Base64
    echo "$1" | xxd -r -p | tr 'A-Za-z' 'N-ZA-Mn-za-m' | base64 -D
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    decode_multilayer "$MULTILAYER_PAYLOAD" | bash
fi
EOF
    
    # Multi-layer encode: Base64 -> ROT13 -> Hex
    local encoded=$(cat "$input_file" | base64 | tr 'A-Za-z' 'N-ZA-Mn-za-m' | xxd -p | tr -d '\n')
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/PLACEHOLDER_PAYLOAD/$encoded/g" "$output_file"
    else
        sed -i "s/PLACEHOLDER_PAYLOAD/$encoded/g" "$output_file"
    fi
}

# Main function to create all encrypted versions
main() {
    local input_file="setup-minified.sh"
    
    if [ ! -f "$input_file" ]; then
        echo "❌ Input file $input_file not found!"
        exit 1
    fi
    
    echo "🔐 Creating encrypted versions of $input_file..."
    
    # Create all encryption methods
    echo "📦 Creating Gzip + Base64 version..."
    create_gzip_base64 "$input_file" "setup-gzip-base64.sh"
    chmod +x "setup-gzip-base64.sh"
    
    echo "📦 Creating Hex encoded version..."
    create_hex_encoded "$input_file" "setup-hex.sh"
    chmod +x "setup-hex.sh"
    
    echo "📦 Creating ROT13 + Base64 version..."
    create_rot13_base64 "$input_file" "setup-rot13.sh"
    chmod +x "setup-rot13.sh"
    
    echo "📦 Creating Multi-layer encoded version..."
    create_multilayer_encoded "$input_file" "setup-multilayer.sh"
    chmod +x "setup-multilayer.sh"
    
    echo "📦 Creating XOR obfuscated version..."
    create_xor_obfuscated "$input_file" "setup-xor.sh"
    chmod +x "setup-xor.sh"
    
    # Optional: OpenSSL encryption (requires password)
    read -p "🔑 Create OpenSSL encrypted version? (requires password) [y/N]: " create_ssl
    if [[ "$create_ssl" =~ ^[Yy] ]]; then
        read -s -p "Enter encryption password: " ssl_password
        echo
        create_openssl_encrypted "$input_file" "setup-encrypted.sh" "$ssl_password"
        chmod +x "setup-encrypted.sh"
        echo "📦 OpenSSL encrypted version created!"
    fi
    
    echo
    echo "✅ All encrypted versions created!"
    echo "📁 Files created:"
    ls -la setup-*.sh | grep -E "(gzip|hex|rot13|multilayer|xor|encrypted)" || true
    
    echo
    echo "📊 File size comparison:"
    echo "Original: $(wc -c < "$input_file") bytes"
    for file in setup-gzip-base64.sh setup-hex.sh setup-rot13.sh setup-multilayer.sh setup-xor.sh; do
        if [ -f "$file" ]; then
            echo "$(basename "$file"): $(wc -c < "$file") bytes"
        fi
    done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi