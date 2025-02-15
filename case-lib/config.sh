#!/bin/bash

# this file is used for defining global variables

# Some variables need manual configuration
# Some commands need to access system node, so they need the sudo password
SUDO_PASSWD=${SUDO_PASSWD:-}

# global define
TPLG_ROOT=${TPLG_ROOT:-/lib/firmware/intel/sof-tplg}

# ignore the target keyword for tplg
# example: ignore 'pipeline ids equal to 2'
# TPLG_IGNORE_LST['id']='2'
# example: ignore 'pcms that are HDA Digital & HDA Analog'
# TPLG_IGNORE_LST['pcm']='HDA Digital,HDA Analog'
declare -A TPLG_IGNORE_LST
# Used in case-lib/pipeline.sh as of October 2020
# shellcheck disable=SC2034
TPLG_IGNORE_LST['pcm']='HDA Digital'

# If not set will be automatically set by logging_ctl function
# Test case log root
# EXAMPLE: the log for test-case/check-ipc-flood.sh will be stored at
#   logs/check-ipc-flood/last
# logs/check-ipc-flood is the link for logs/check-ipc-flood/$(run script date)
LOG_ROOT=${LOG_ROOT:-}

# If not set will be automatically set by log function
# store the sof-logger collect data into LOG_ROOT/case-name/last/
# EXAMPLE: the sof-logger will collect the data into this folder
SOFLOGGER=${SOFLOGGER:-}

# If not set will be automatically set by log function
# Target Sound Card ID, it will be used in func_pipeline_export for Device ID
# example: device id 0, pcm id 0: hw0,0; device id 1, pcm id 0: hw1,0;
SOFCARD=${SOFCARD:-}

# Decision must be made for how to load the root permission command
# 0: run cmd as root
# example: ls /sys/kernel/debug/
# 1: run cmd with sudo, but without sudo password
# example: sudo ls /sys/kernel/debug/
# 2: run cmd with sudo, but needs sudo password
# example: echo $SUDO_PASSWD | sudo -S ls /sys/kernel/debug/
SUDO_LEVEL=${SUDO_LEVEL:-}

# The i915 driver sometimes is not ready on a new platform, sof-test
# will fail because broken HDMI pipelines are present.
# The NO_HDMI_MODE option controls the pipeline filter, if true, HDMI
# pipelines will be filtered out. Example:
#
# NO_HDMI_MODE=true

# Bluetooth connection is not set up on our Linux device.
# The I2S is in slave and there will be no WS/FSYNC from
# the BT side, so audio side will get -EIO.
#
# NO_BT_MODE=true

# SOF_TEST_INTERVAL informs sof-test of how long the external test
# runner waits between the end of one sof-test and the start of the next
# sof-test. sof-test uses this value to assign the corresponding kernel
# logs "no man's land" to the second test, which can be confusing (see
# for instance https://github.com/thesofproject/sof/issues/5032) but
# safer: it makes sure no kernel error escapes.
# See initial review in https://github.com/thesofproject/sof-test/pull/639
#
# The default value must be 5s because 5s is the inter-test delay
# waited by the internal test runner used by sof/jenkins CI and that
# test runner does not define SOF_TEST_INTERVAL (internal bug 158)
SOF_TEST_INTERVAL=${SOF_TEST_INTERVAL:-5}
