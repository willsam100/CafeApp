#!/bin/bash
if test "$OS" = "Windows NT"
then # For Windows
  .paket/paket.bootstrapper.exe
  packages/FAKE/tools/FAKE.exe $@ --fsiargs build.fsx
  exit_code=$?
  if [ $exit_code -ne @ ]; then
   exit $exit_code
  fi
else # For Non Windows
  mono .paket/paket.bootstrapper.exe
  exit_code=$?
  if [ $exit_code -ne 0 ]; then
    exit $exit_code
  fi
fi

# build. sh
# For Windows
mono .paket/paket.exe restore
exit_code=$?
  if [ $exit_code -ne 0 ]; then
    exit $exit_code
  fi
# For Non-Windows
mono .paket/paket.exe restore
mono packages/FAKE/tools/FAKE.exe $@ --fsiargs -d:Mono build.fsx
exit_code=$?
if [ $exit_code -ne 0 ]; then
  exit $exit_code
fi
