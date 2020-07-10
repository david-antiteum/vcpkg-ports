include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO frankosterfeld/qtkeychain
    REF master
    SHA512 ed48688eaed2b07edc868be4bb9ccd86db8b847f6dee536937a765ae8e0f71b6dc5d5b8a3f05c4a81e1b0cc2037a5f62d157d397772f45d9a0e35d9099e520dd
    HEAD_REF master
)

list(APPEND QTKEYCHAIN_OPTIONS -DCMAKE_DEBUG_POSTFIX=d)
list(APPEND QTKEYCHAIN_OPTIONS -DBUILD_TEST_APPLICATION:BOOL=OFF)
if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    list(APPEND QTKEYCHAIN_OPTIONS -DQTKEYCHAIN_STATIC:BOOL=ON)
else()
    list(APPEND QTKEYCHAIN_OPTIONS -DQTKEYCHAIN_STATIC:BOOL=OFF)
endif()

if (CMAKE_HOST_WIN32)
    list(APPEND QTKEYCHAIN_OPTIONS -DBUILD_TRANSLATIONS:BOOL=ON)
else()
    list(APPEND QTKEYCHAIN_OPTIONS -DBUILD_TRANSLATIONS:BOOL=OFF)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
	OPTIONS ${QTKEYCHAIN_OPTIONS}
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

# Remove unneeded dirs
file(REMOVE_RECURSE 
	${CURRENT_PACKAGES_DIR}/debug/include
	${CURRENT_PACKAGES_DIR}/debug/lib/cmake
	${CURRENT_PACKAGES_DIR}/lib/cmake
)

# Handle copyright
file(COPY ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/qtkeychain)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/qtkeychain/COPYING ${CURRENT_PACKAGES_DIR}/share/qtkeychain/copyright)