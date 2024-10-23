find_program (GIT git)

set (GIT_URL "https://github.com/Do-sth-sharp/check-vcpkg.git")
set (GIT_REV "dc2797e53a8832c4955d7798c4b02b7817b88886")

set (SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src)

if (EXISTS "${SOURCE_PATH}")
	file (REMOVE_RECURSE "${SOURCE_PATH}")
endif ()
if (NOT EXISTS "${SOURCE_PATH}")
	file (MAKE_DIRECTORY "${SOURCE_PATH}")
endif ()

message (STATUS "Cloning and fetching submodules")
vcpkg_execute_required_process (
	COMMAND ${GIT} clone --recurse-submodules ${GIT_URL} ${SOURCE_PATH}
	WORKING_DIRECTORY ${SOURCE_PATH}
	LOGNAME clone
)

message (STATUS "Checkout revision ${GIT_REV}")
vcpkg_execute_required_process (
	COMMAND ${GIT} checkout ${GIT_REV}
	WORKING_DIRECTORY ${SOURCE_PATH}
	LOGNAME checkout
)
vcpkg_execute_required_process (
	COMMAND ${GIT} submodule update --recursive
	WORKING_DIRECTORY ${SOURCE_PATH}
	LOGNAME submodule-update
)

vcpkg_cmake_configure (
	SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install ()
vcpkg_cmake_config_fixup (PACKAGE_NAME ${PORT} CONFIG_PATH lib/cmake/${PORT})
#vcpkg_copy_pdbs ()

 set (VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
 set (VCPKG_POLICY_ALLOW_EXES_IN_BIN enabled)
 set (VCPKG_POLICY_ALLOW_EMPTY_FOLDERS enabled)

file (REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file (REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file (INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
