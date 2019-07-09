#!/usr/bin/env bash

#COLORS -
red=$'\e[1;31m'
grn=$'\e[1;32m'
blu=$'\e[1;34m'
end=$'\e[0m'

# Assumes source is in users home in a directory called "wave"
WAVE_PATH="${HOME}/wave"

# Set the tag you want to merge
read -p "Enter the CAF tag you want to merge : " TAG

# Set the base URL for all repositories to be pulled from
CAF="https://source.codeaurora.org"

do_not_merge="device/qcom/common external/exfat manifest vendor/codeaurora/commonsys/telephony vendor/qcom/opensource/commonsys/bluetooth vendor/qcom/opensource/commonsys/bluetooth_ext vendor/qcom/opensource/commonsys/fm vendor/qcom/opensource/commonsys/system/bt vendor/qcom/opensource/commonsys-intf/display vendor/wave"

# wave manifest is setup with repo name first, then repo path, so the path attribute is after 3 spaces, and the path itself within "" in it
repos="$(grep 'remote="wave"' ${WAVE_PATH}/.repo/manifests/wave.xml  | awk '{print $2}' | awk -F '"' '{print $2}')"

cd ${WAVE_PATH}

for filess in failed success notcaf unchanged; do
    rm $filess 2> /dev/null
    touch $filess
done

for REPO in ${repos}; do
    echo -e ""
    if [[ "${do_not_merge}" =~ "${REPO}" ]]; then
        echo -e "${REPO} is not to be merged"
    else
        echo "$blu Merging $REPO $end"
        echo -e ""
        cd $REPO
        git checkout p
        git fetch wave p
        git reset --hard wave/p
        git remote rm caf 2> /dev/null
        if [[ "${REPO}" == "device/qcom/sepolicy" ]]; then
            reponame="${CAF}/${REPO}"
        elif [[ "${REPO}" == "build/make" ]]; then
            reponame="${CAF}/platform/build"
        elif [[ "${REPO}" =~ "vendor/qcom" ]]; then
            reponame="${CAF}/platform/$(echo ${REPO} | sed -e 's|qcom/opensource|qcom-opensource|')"
        else
            reponame="${CAF}/platform/$REPO"
        fi
        git remote add caf "${reponame}"
        git fetch caf --quiet --tags
        if [ $? -ne 0 ]; then
            echo "$repos" >> ${WAVE_PATH}/notcaf
        else
            git merge ${TAG} --no-edit
            if [ $? -ne 0 ]; then
                echo "$REPO" >> ${WAVE_PATH}/failed
                echo "$red $REPO failed :( $end"
            else
                if [[ "$(git rev-parse HEAD)" != "$(git rev-parse wave/p)" ]]; then
                    echo "$REPO" >> ${WAVE_PATH}/success
                    echo "$grn $REPO succeeded $end"
                else
                    echo "$REPO - unchanged"
                fi
            fi
            echo -e ""
        fi
        cd ${WAVE_PATH}
    fi
done

echo -e ""
echo -e "$red These REPO failed $end"
cat ./failed
echo -e ""
echo -e "$grn These succeeded $end"
cat ./success

# What's got succeed
SUCCEED="$(cat success)"

# Push them
for succeed in ${SUCCEED}; do
    cd $succeed
    git push $(git remote -v | grep wave | head -1 | awk '{print $2}') HEAD:p
    cd -
done
