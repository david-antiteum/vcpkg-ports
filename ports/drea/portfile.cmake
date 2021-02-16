vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO david-antiteum/drea
    REF v0.10.1
    SHA512 dea44826bf60fb8b52b74be3a47c6fb49d4995d8047908bff5893896bde2532c9bd4b2fe739c008ff8757d6d98160effc7d685daba864bd0beebb162fa63fe29
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_EXAMPLES=OFF
        -DBUILD_TESTING=OFF
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/drea RENAME copyright)

# Remove duplicate info
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
