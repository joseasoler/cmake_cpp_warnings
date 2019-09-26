#include <iostream>

// Main function implemented to trigger warnings on purpose.
int main() {
    float uninitialized;
    std::cout << uninitialized * 2.0 * 0x34 << '\n';
}
