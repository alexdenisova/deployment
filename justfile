# Use with <https://github.com/casey/just>

export KUBE_CONTEXT := "home"
export VALUES_DIR := "values"
export CHARTS_DIR := "helm-charts"
export VALUES_PATTERN := '*values.yaml'
export SECRETS_PATTERN := '*sops.yaml'
export RELEASE_NAME := "app"

deploy CHART NAMESPACE:
    #!/bin/bash
    set -eu
    values_dir=$(realpath "${VALUES_DIR}/{{ CHART }}")
    common_dir=$(realpath ${VALUES_DIR})
    HLM_VALUES=($(find "${common_dir}" "${values_dir}" -maxdepth 1 -type f -iname "${VALUES_PATTERN}"))
    HLM_SECRETS=($(find "${common_dir}" "${values_dir}" -maxdepth 1 -type f -iname "${SECRETS_PATTERN}"))
    command="helm upgrade --install --wait --wait-for-jobs --timeout 20m --kube-context ${KUBE_CONTEXT} --namespace {{ NAMESPACE }}"
    for value in "${HLM_VALUES[@]}"; do
        command="$(printf '%s --values %s' "$command" "$value")"
    done
    for value in "${HLM_SECRETS[@]}"; do
        command="$(printf '%s --values secrets://%s' "$command" "$value")"
    done
    for i in $(find "${values_dir}" -maxdepth 1 -type f -iname '*.env' | sort); do
        eval $(sed -e 's/^/export /' "${i}")
    done
    chart="${CHARTS_DIR}/{{ CHART }}"
    command="$(printf '%s %s %s' "$command" "${RELEASE_NAME}" "${chart}")"
    echo "$command"
    eval "$command"
