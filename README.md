# CMake C++ Warnings

A CMake module that defines an extensive set of reasonable warnings to be used in modern C++ projects. The module supports GCC, Clang and Microsoft Visual C++. Warnings that are only supported in newer compiler versions will not be enabled in older versions. The documentation of each enabled warning includes a short summary about its purpose.

## Getting Started

Download the [cpp_warnings.cmake](https://raw.githubusercontent.com/joseasoler/cmake_cpp_warnings/master/cmake/cpp_warnings.cmake) CMake module and add it to your project. In your CMakeLists.txt file, you should include it after your project is defined and the language is set to C++. To use the warnings in a target, you can use target_compile_options.

`target_compile_options(targetName PRIVATE ${PROJECT_WARNING_FLAGS})`

## Recommended usage

It is easier to develop code without warnings from scratch than to refactor it later. So initially the set of enabled warnings should be as extensive as possible. Specific warnings can be disabled later in the development process if it is decided that it makes sense for the project or if they trigger false positives.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments
* **[Craig Scott](https://crascit.com/)** - [Professional CMake](https://crascit.com/professional-cmake/)
* **[Jason Turner](https://github.com/lefticus)** - [C++ Best Practices](https://lefticus.gitbooks.io/cpp-best-practices/)
* **[Peter Kolbus](https://github.com/pkolbus)** - [Compiler Warnings](https://github.com/pkolbus/compiler-warnings)
