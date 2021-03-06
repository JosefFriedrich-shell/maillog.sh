#!/usr/bin/env bat

setup() {
	. ./test/lib/test-helper.sh
	mock_path test/bin
	export MAILLOG_EMAIL=test@example.com
}

@test "execute: maillog.sh" {
	run ./maillog.sh
	[ "$status" -eq 1 ]
	[ "${lines[0]}" = "Usage: maillog.sh [-b BODY ] <subject> <text-file-to-send>" ]
}

@test "execute: maillog.sh -h" {
	run ./maillog.sh -h
	[ "$status" -eq 0 ]
	[ "${lines[0]}" = "Usage: maillog.sh [-b BODY ] <subject> <text-file-to-send>" ]
}

@test "execute: maillog.sh -t" {
	OUTPUT=$(./maillog.sh -t)
	test -n "$(echo $OUTPUT | grep 'Test mail test@example.com')"
	test -n "$(echo $OUTPUT | grep 'Sending test mail to test@example.com.')"
}
