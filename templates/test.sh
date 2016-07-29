#!/bin/bash
#
# Runs tests via xcodebuild, formatting results with xcpretty.
#
# Usage: bin/test [options]
#
# Options:
#   -k    Clean before running the tests.
#   -r    Emit JUnit XML report.
#   -t    Use RSpec-style test output.

set -eo pipefail

build_actions=(test)
test_reports_dir="${CIRCLE_TEST_REPORTS:-build}"
xcpretty_options=(--color)

while getopts krt opt; do
  case ${opt} in
    k)
      build_actions=(clean test)
      ;;
    r)
      xcpretty_options+=(--report junit --output "${test_reports_dir}/test-report.xml")
      ;;
    t)
      xcpretty_options+=(--test)
      ;;
    *)
      exit 1
      ;;
  esac
done

shift $((OPTIND - 1))

mkdir -p "${test_reports_dir}"

env NSUnbufferedIO=YES xcrun xcodebuild \
  -workspace <%= project_name %>.xcworkspace \
  -scheme <%= project_name %> \
  -sdk iphonesimulator \
  BUILD_ACTIVE_ARCH=NO \
  "${build_actions[@]}" \
  | xcpretty "${xcpretty_options[@]}"
