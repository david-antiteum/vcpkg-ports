include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO david-antiteum/drea
    REF v0.0.1-1
    SHA512 95be93e466bc46e722e8ed74ec63521eb75a98a99a799f77c407750348421fe0c34e175468b4edfaea9ca2549b00d4b52da7ad5475a3b030914708aefbce5832
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_EXAMPLES=OFF
        -DBUILD_TOOLS=OFF
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/drea RENAME copyright)

# Remove duplicate info
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

# CMake integration test
vcpkg_test_cmake(PACKAGE_NAME ${PORT})
