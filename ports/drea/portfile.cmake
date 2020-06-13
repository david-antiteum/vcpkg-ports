include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO david-antiteum/drea
    REF v0.0.7
    SHA512 412fb8c2671ecc7eb3070a69b7ef04aef48542fa46707bdce33313ce705cde197bc402868d8e956f29db211bb9e81b50027e75812122bd1d9bcbf35cf79e8141
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_EXAMPLES=OFF
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/drea RENAME copyright)

# Remove duplicate info
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

# CMake integration test
vcpkg_test_cmake(PACKAGE_NAME ${PORT})
