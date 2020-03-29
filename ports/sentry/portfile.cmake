include(vcpkg_common_functions)

find_program(GIT git)

set( GIT_URL "https://github.com/getsentry/sentry-native.git" )
set( GIT_REF "0.2.2" )

set( SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${GIT_REF} )

if(NOT EXISTS "${SOURCE_PATH}")
    message(STATUS "Cloning")
    vcpkg_execute_required_process(
        COMMAND ${GIT} clone --recurse-submodules ${GIT_URL} ${SOURCE_PATH} --branch ${GIT_REF}
        WORKING_DIRECTORY ${DOWNLOADS}
        LOGNAME clone
    )
endif()
message(STATUS "Cloning done in ${SOURCE_PATH}" )

if( WIN32 )
	set( SENTRY_TRANSPORT "winhttp" )
	set( SENTRY_BACKEND "crashpad" )
elseif( APPLE )
	set( SENTRY_TRANSPORT "curl" )
	set( SENTRY_BACKEND "crashpad" )
else()
	set( SENTRY_TRANSPORT "curl" )
	set( SENTRY_BACKEND "breakpad" )
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DSENTRY_BUILD_TESTS=OFF
        -DSENTRY_BUILD_EXAMPLES=OFF
        -DSENTRY_TRANSPORT=${SENTRY_TRANSPORT}
        -DSENTRY_BACKEND=${SENTRY_BACKEND}
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets( CONFIG_PATH lib/cmake/${PORT} TARGET_PATH share/${PORT} )

vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

# Debug cleanup
file( REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include ${CURRENT_PACKAGES_DIR}/debug/share )

# Tools
if( WIN32 )
	file( MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/${PORT}/ )
	file( RENAME ${CURRENT_PACKAGES_DIR}/bin/crashpad_handler.exe ${CURRENT_PACKAGES_DIR}/tools/${PORT}/crashpad_handler.exe )
	vcpkg_copy_tool_dependencies( ${CURRENT_PACKAGES_DIR}/tools/${PORT} )
	file( REMOVE ${CURRENT_PACKAGES_DIR}/debug/bin/crashpad_handler.exe )
elseif( APPLE )

else()

endif()
