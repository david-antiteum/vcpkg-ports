include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO bluetiger9/SmtpClient-for-Qt
    REF master
    SHA512 7a4ae1bd397e51230ab2b66c4afe4643ccfd15c5d28cc93807e016ebb3f2da3ba7b001d3c480fd6b60cad44e4f33d3cc986b1c04e9de6ba10d79eb2e30e11f16
    HEAD_REF master
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/smtpclient-for-qt RENAME copyright)

# Remove duplicate info
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

# CMake integration test
vcpkg_test_cmake(PACKAGE_NAME ${PORT})
