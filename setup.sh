#!/bin/bash

path="${dir}/public_html"

if [[ "${production}" == "false" || "${production}" == "False" ]]; then
    if [[ "${provision}" == "true" || "${provision}" == "True" ]]; then
        if [[ ${type} == "ClassicPress" || ${type} == "classicpress" ]]; then
            if [[ ! -f "${path}/wp-config.php" ]]; then
                wp core download --quiet --path="${path}" https://www.classicpress.net/latest.zip
                wp config create --dbhost=mariadb --dbname=${domain} --dbuser=classicpress --dbpass=classicpress --quiet --path="${path}"
                wp core install  --url="https://{domain}.test" --title="${domain}.test" --admin_user=${username} --admin_password=${password} --admin_email="admin@${domain}.test" --skip-email --quiet --path="${path}"
                wp config set --type=constant DISALLOW_FILE_EDIT --raw true --quiet --path="${path}"
            fi
        fi
    fi
elif [[ "${production}" == "true" || "${production}" == "True" ]]; then
    if [[ "${provision}" == "true" || "${production}" == "True" ]]; then
        if [[ "${type}" == "ClassicPress" || "${type}" == "classicpress" ]]; then
            if [[ ! -f "${path}/wp-config.php" ]]; then
                wp core download --quiet --path="${path}" https://www.classicpress.net/latest.zip
                wp config create --dbhost=mariadb --dbname=${domain} --dbuser=classicpress --dbpass=classicpress --quiet --path="${path}"
                wp core install  --url="https://{domain}.com" --title="${domain}.com" --admin_user=${username} --admin_password=${password} --admin_email=${email} --skip-email --quiet --path="${path}"
                wp config set --type=constant DISALLOW_FILE_EDIT --raw true --quiet --path="${path}"
            fi
        else 
            if [[ ! -f "${path}/index.html" ]]; then
                mkdir -p "${path}"
                touch "${path}/index.html"
            fi
        fi
    fi
fi