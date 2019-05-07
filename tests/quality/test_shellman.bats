load data

__get_tag() {
  local re='^[[:space:]]*##[[:space:]]*[@\]'"$1"'[[:space:]]'
  grep "${re}" "$2" | expand | sed 's/'"${re}"'*//'
  # shellcheck disable=SC2086
  return ${PIPESTATUS[0]}
}

_has_tag() {
  local script status=${success}
  local checked_tag="$1"
  shift
  for script in "$@"; do
    if ! __get_tag "${checked_tag}" "${script}" >/dev/null; then
      echo "${script}: missing tag ${checked_tag}"
      status=${failure}
    fi
  done
  return ${status}
}

_usage_matches_script_name() {
  local script usage usages status=${success}
  for script in "$@"; do
    if usages=$(__get_tag "usage" "${script}" | cut -d' ' -f1); then
      for usage in ${usages}; do
        if [ "${usage}" != "$(basename "${script}")" ]; then
          echo "${script}: usage '${usage}' does not match script name"
          status=${failure}
        fi
      done
    fi
  done
  return ${status}
}

@test "scripts have usage tag" {
  _has_tag "usage" ${scripts}
}

@test "scripts have brief tag" {
  _has_tag "brief" ${scripts}
}

@test "scripts usages match names" {
  _usage_matches_script_name ${scripts}
}
