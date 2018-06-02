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
#   - extended_apis
#   - config.cmake
#
# Change the options as needed, and then from the build folder, run the
# following:
#
# > cd working/build
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

# Tests only
#
# If you are only interested in compiling the tests, this option can speed up
# your build times .
set(ENABLE_TESTS_ONLY OFF)

set(CACHE_DIR ${CMAKE_CURRENT_LIST_DIR}/cache)

set(CMAKE_BUILD_TYPE Debug)
set(ENABLE_FORMAT ON)
set(ENABLE_BUILD_EFI ON)
set(BUILD_STATIC_LIBS ON)
set(ENABLE_FORMAT ON)

# Extended APIs
#
# This turns on the extended APIs, and assumes the repo is located in the same
# directory as this configuration file.
#
if(ENABLE_EXTENDED_APIS)
    set_bfm_vmm(eapis_vmm)
    list(APPEND EXTENSION
        ${CMAKE_CURRENT_LIST_DIR}/eapis
    )
endif()
