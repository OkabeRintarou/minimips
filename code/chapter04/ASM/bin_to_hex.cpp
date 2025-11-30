#include <iostream>
#include <fstream>
#include <iomanip>
#include <cstdint>

// Function to check if the system is little-endian
bool is_little_endian() {
    uint16_t test = 0x0001;
    return *(uint8_t*)&test == 1;
}

// Function to convert endianness if needed
uint32_t convert_to_big_endian(uint32_t value) {
    if (is_little_endian()) {
        // If system is little-endian, convert to big-endian
        return ((value & 0x000000FF) << 24) |
               ((value & 0x0000FF00) << 8)  |
               ((value & 0x00FF0000) >> 8)  |
               ((value & 0xFF000000) >> 24);
    } else {
        // System is already big-endian, no conversion needed
        return value;
    }
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        std::cerr << "Usage: " << argv[0] << " <input_bin_file> <output_hex_file>" << std::endl;
        return 1;
    }

    // Open input binary file
    std::ifstream input_file(argv[1], std::ios::binary);
    if (!input_file) {
        std::cerr << "Error: Cannot open input file " << argv[1] << std::endl;
        return 1;
    }

    // Open output hex file
    std::ofstream output_file(argv[2]);
    if (!output_file) {
        std::cerr << "Error: Cannot create output file " << argv[2] << std::endl;
        return 1;
    }

    // Read 4 bytes at a time (MIPS32 instruction size)
    uint32_t instruction;
    while (input_file.read(reinterpret_cast<char*>(&instruction), sizeof(instruction))) {
        // Convert to big-endian if needed
        uint32_t big_endian_inst = convert_to_big_endian(instruction);
        
        // Output in big-endian hexadecimal format (as expected by Verilog)
        output_file << std::hex << std::uppercase << std::setfill('0') << std::setw(8) << big_endian_inst << std::endl;
    }

    // Check if we reached end of file normally
    if (!input_file.eof()) {
        std::cerr << "Warning: Incomplete read from input file" << std::endl;
    }

    input_file.close();
    output_file.close();

    std::cout << "Conversion completed successfully!" << std::endl;
    std::cout << "Input: " << argv[1] << std::endl;
    std::cout << "Output: " << argv[2] << std::endl;
    
    // Display endian information
    std::cout << "System endianness: " << (is_little_endian() ? "Little-endian" : "Big-endian") << std::endl;
    std::cout << "MIPS target endianness: Big-endian" << std::endl;

    return 0;
}