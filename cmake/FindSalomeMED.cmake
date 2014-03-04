# - Try to find MED component of Salome
# Once done this will define
#  SalomeMED_FOUND - System has Salome MED
#  SalomeMED_INCLUDE_DIRS - The Salome MED include directories
#  SalomeMED_LIBRARIES - The libraries needed to use Salome MED
#  SalomeMED_DEFINITIONS - Compiler switches required for using Salome MED

set(SalomeMED_DIR SalomeMED_DIR-NOTFOUND CACHE PATH "Salome MED component path")

find_path(SalomeMED_INCLUDE_DIR salome/MED.hh
          HINTS ${SalomeMED_DIR}/include ${SALOME_DIR}/modules/MED*/include
          PATH_SUFFIXES salome
)

find_library(SalomeMED_coupling_LIBRARY
             NAMES medcoupling
             HINTS  ${SalomeMED_DIR}/lib/salome ${SALOME_DIR}/modules/MED*/lib/salome
)

find_library(SalomeMED_loader_LIBRARY
             NAMES medloader
             HINTS  ${SalomeMED_DIR}/lib/salome ${SALOME_DIR}/modules/MED*/lib/salome
)

find_library(SalomeMED_interpkernel_LIBRARY
             NAMES interpkernel
             HINTS  ${SalomeMED_DIR}/lib/salome ${SALOME_DIR}/modules/MED*/lib/salome
)

set(SalomeMED_LIBRARIES ${SalomeMED_coupling_LIBRARY} ${SalomeMED_loader_LIBRARY} ${SalomeMED_interpkernel_LIBRARY})
set(SalomeMED_INCLUDE_DIRS ${SalomeMED_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set MED_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(SalomeMED DEFAULT_MSG
                                  SalomeMED_coupling_LIBRARY
                                  SalomeMED_loader_LIBRARY
                                  SalomeMED_interpkernel_LIBRARY
                                  SalomeMED_INCLUDE_DIR
)

mark_as_advanced(SalomeMED_INCLUDE_DIR SalomeMED_coupling_LIBRARY SalomeMED_loader_LIBRARY SalomeMED_interpkernel_LIBRARY)
