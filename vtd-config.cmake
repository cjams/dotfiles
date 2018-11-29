#
# Bareflank Hypervisor
# Copyright (C) 2015 Assured Information Security, Inc.
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA

# ------------------------------------------------------------------------------
# README
# ------------------------------------------------------------------------------

# To use this config, put this file in the same folder that contains the
# hypervisor and build folder, (and extended apis if your using them), and
# rename it to "config.cmake". For example:
#
# - working
#   - build
#   - hypervisor
#   - extended_apis                     # optional
#   - hypervisor_example_vpid           # optional
#   - hypervisor_example_rdtsc          # optional
#   - hypervisor_example_cpuidcount     # optional
#   - hypervisor_example_msr_bitmap     # optional
#   - config.cmake
#
# Change the options as needed, and then from the build folder, run the
# following:
#
# > cmake ../hypervisor
# > make -j<# of cpus>
#

# *** WARNING ***
#
# Configuration variables can only be set prior to running "make". Once the
# build has started, a new build folder is needed before any configuration
# changes can be made.

# ------------------------------------------------------------------------------
# Options
# ------------------------------------------------------------------------------

# Extended APIs
#
# This option enables the use of the extended APIs. It assumes the extended
# APIs are located in the same directory as this configuration file.
#
set(ENABLE_EXTENDED_APIS ON)

# Hyperkernel
#
# This option enables the use of the hyperkernel. It assumes the
# hyperkernel is located in the same directory as this configuration file.
#
set(ENABLE_HYPERKERNEL ON)

# Enable EFI
#
# This will enable building EFI targets after the VMM has compiled. Note that
# this forces static build, disables testing, ASAN, codecov and clang tidy,
# and requries the VMM be compiled
#
set(ENABLE_BUILD_EFI ON)

set(CMAKE_BUILD_TYPE Debug)
set(BUILD_SHARED_LIBS OFF)
set(BUILD_STATIC_LIBS ON)
set(ENABLE_BUILD_TEST OFF)
set(ENABLE_ASAN OFF)
set(ENABLE_TIDY OFF)
set(ENABLE_FORMAT OFF)
set(ENABLE_CODECOV OFF)
set(ENABLE_COMPILER_WARNINGS ON)
set(CACHE_DIR ${CMAKE_CURRENT_LIST_DIR}/cache)

# ------------------------------------------------------------------------------
# Extended APIs
# ------------------------------------------------------------------------------

if(ENABLE_EXTENDED_APIS)
    set_bfm_vmm(eapis_bfvmm)
    list(APPEND EXTENSION
        ${CMAKE_CURRENT_LIST_DIR}/eapis
    )
    if(ENABLE_VTD)
        list(APPEND EXTENSION
            ${CMAKE_CURRENT_LIST_DIR}/vtd_sandbox
        )
    endif()
endif()

# ------------------------------------------------------------------------------
# Hyperkernel
# ------------------------------------------------------------------------------

if(ENABLE_HYPERKERNEL)
    set_bfm_vmm(hyperkernel_bfvmm)
    list(APPEND EXTENSION
        ${CMAKE_CURRENT_LIST_DIR}/kernel
    )
endif()

# ------------------------------------------------------------------------------
# Override VMM
# ------------------------------------------------------------------------------

if(OVERRIDE_VMM)
    if(OVERRIDE_VMM_TARGET)
        set_bfm_vmm(${OVERRIDE_VMM} TARGET ${OVERRIDE_VMM_TARGET})
    else()
        set_bfm_vmm(${OVERRIDE_VMM})
    endif()
endif()
