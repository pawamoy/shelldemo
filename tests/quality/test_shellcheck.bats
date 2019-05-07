load data

@test "shellcheck on scripts" {
  if [ ! -n "${scripts}" ]; then
    skip "- no scripts to check"
  fi
  shellcheck -x ${scripts}
}

@test "shellcheck on libraries" {
  if [ ! -n "${libs}" ]; then
    skip "- no libraries to check"
  fi
  shellcheck -xe SC2148 ${libs}
}
