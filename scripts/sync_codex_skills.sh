#!/usr/bin/env bash

set -euo pipefail

SOURCE_DIR="${1:-}"
TARGET_DIR="${2:-}"

if [[ -z "${SOURCE_DIR}" || -z "${TARGET_DIR}" ]]; then
  echo "usage: $0 <source-skills-dir> <target-codex-skills-dir>" >&2
  exit 1
fi

if [[ ! -d "${SOURCE_DIR}" ]]; then
  echo "source directory does not exist: ${SOURCE_DIR}" >&2
  exit 1
fi

mkdir -p "${TARGET_DIR}"

found_skill=0
for skill_dir in "${SOURCE_DIR}"/*; do
  if [[ ! -d "${skill_dir}" ]]; then
    continue
  fi

  skill_name="$(basename "${skill_dir}")"
  skill_file="${skill_dir}/SKILL.md"

  if [[ ! -f "${skill_file}" ]]; then
    echo "skipping ${skill_name}: missing SKILL.md" >&2
    continue
  fi

  found_skill=1
  rm -rf "${TARGET_DIR}/${skill_name}"
  mkdir -p "${TARGET_DIR}/${skill_name}"
  cp -R "${skill_dir}/." "${TARGET_DIR}/${skill_name}/"
  echo "synced ${skill_name} -> ${TARGET_DIR}/${skill_name}"
done

if [[ "${found_skill}" -eq 0 ]]; then
  echo "no skill directories with SKILL.md found in ${SOURCE_DIR}" >&2
  exit 1
fi
