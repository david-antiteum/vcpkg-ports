include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO david-antiteum/mailio
    REF master
    SHA512 c0a5eac0b76f7320fa85dbe44da1bfa4803aa0fc4c307a4b1a1386f0a36e2b41891db21992fb41459fbb33af8403f545525cd6f18c70c2c5f2c68889427d3ec1
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DMAILIO_BUILD_DOCUMENTATION=OFF
        -DMAILIO_BUILD_EXAMPLES=OFF
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/mailio RENAME copyright)

# Remove duplicate info
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

# CMake integration test
vcpkg_test_cmake(PACKAGE_NAME ${PORT})
