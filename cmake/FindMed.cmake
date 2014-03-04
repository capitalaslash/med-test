# - Try to find med library
# Once done this will define
#  MED_FOUND - System has MED
#  MED_INCLUDE_DIRS - The MED include directories
#  MED_LIBRARIES - The libraries needed to use MED
#  MED_DEFINITIONS - Compiler switches required for using MED

set(MED_DIR MED_DIR-NOTFOUND CACHE PATH "Med library path")

find_path(MED_INCLUDE_DIR med.h
          HINTS ${MED_DIR}/include ${SALOME_DIR}/prerequisites/med*/include
          PATH_SUFFIXES med
)

find_library(MED_LIBRARY
             NAMES med
             HINTS  ${MED_DIR}/lib ${SALOME_DIR}/prerequisites/med*/lib
)

find_library(MEDC_LIBRARY
             NAMES medC
             HINTS  ${MED_DIR}/lib ${SALOME_DIR}/prerequisites/med*/lib
)

set(MED_LIBRARIES ${MED_LIBRARY} ${MEDC_LIBRARY})
set(MED_INCLUDE_DIRS ${MED_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set MED_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(MED DEFAULT_MSG
                                  MED_LIBRARY
                                  MED_INCLUDE_DIR
)

mark_as_advanced(MED_INCLUDE_DIR MED_LIBRARY MEDC_LIBRARY)
