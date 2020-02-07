cmake_minimum_required( VERSION 3.12...3.16 )

if( DEFINED ENV{VCPKG_ROOT} AND NOT DEFINED CMAKE_TOOLCHAIN_FILE )
	message( "Using vcpkg settings: $ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake" )
	set( CMAKE_TOOLCHAIN_FILE "$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake" CACHE STRING "" )
endif()

project( smtpclient-for-qt VERSION 1.1 DESCRIPTION "An SMTP Client written in C++ for Qt. Allows applications to send emails (MIME with text, html, attachments, inline files, etc.) via SMTP. Supports SSL and SMTP authentication." LANGUAGES CXX )

find_package( Qt5 REQUIRED COMPONENTS Core Network )

#if( BUILD_SHARED_LIBS )
	add_compile_definitions( SMTP_BUILD )
	set( LIB_TYPE SHARED )
#else()
#	set( LIB_TYPE STATIC )
#endif()

set( HEADERS 
	src/emailaddress.h
	src/mimeattachment.h
	src/mimefile.h
	src/mimehtml.h
	src/mimeinlinefile.h
	src/mimemessage.h
	src/mimepart.h
	src/mimetext.h
	src/smtpclient.h
	src/SmtpMime
	src/quotedprintable.h
	src/mimemultipart.h
	src/mimecontentformatter.h
	src/smtpexports.h
)
set( SOURCES
	src/emailaddress.cpp
	src/mimeattachment.cpp
	src/mimefile.cpp
	src/mimehtml.cpp
	src/mimeinlinefile.cpp
	src/mimemessage.cpp
	src/mimepart.cpp
	src/mimetext.cpp
	src/smtpclient.cpp
	src/quotedprintable.cpp
	src/mimemultipart.cpp
	src/mimecontentformatter.cpp
)
add_library( ${PROJECT_NAME} ${LIB_TYPE} 
	${SOURCES}
	${HEADERS}
)
target_link_libraries( ${PROJECT_NAME} 
	Qt5::Core Qt5::Network
)

set_target_properties( ${PROJECT_NAME} 
	PROPERTIES
		RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin" 
		LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/lib" 
		VERSION ${PROJECT_VERSION}
		SOVERSION 1
		AUTOMOC TRUE
		AUTORCC TRUE
		AUTOUIC TRUE	
)

include(GNUInstallDirs)

install(TARGETS ${PROJECT_NAME} EXPORT ${PROJECT_NAME}Config
	ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
	LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
	RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
install( FILES ${HEADERS} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME} )

install(EXPORT ${PROJECT_NAME}Config DESTINATION share/${PROJECT_NAME}/cmake)

export(TARGETS ${PROJECT_NAME} FILE ${PROJECT_NAME}Config.cmake)
