#!/usr/bin/env bash
# Script to merge latest CAF tag in WaveOS sources
# Run it in the root of ROM source

# Colors
red=$'\e[1;31m'
grn=$'\e[1;32m'
blu=$'\e[1;34m'
end=$'\e[0m'

# Assumes user is running the script in root of source
WAVE_PATH=$(pwd)
BRANCH=p

# Get merge tag from user
read -p "Enter the CAF tag you want to merge: " TAG

# Set the base URL for all repositories to be pulled from
CAF="https://source.codeaurora.org/quic/la"

blacklist="device/qcom/common \
    manifest \
    hardware/qcom/keymaster \
    vendor/wave \
    packages/apps/MusicFX \
    vendor/qcom/opensource/power"

reset_branch () {
  git checkout $BRANCH &> /dev/null
  git fetch wave $BRANCH &> /dev/null
  git reset --hard wave/$BRANCH &> /dev/null
}

repos="$(grep 'remote="wave"' $WAVE_PATH/.repo/manifests/wave.xml  | awk '{print $2}' | awk -F '"' '{print $2}')"

for files in failed success notcaf unchanged; do
    rm $files 2> /dev/null
    touch $files
done

for REPO in $repos; do
    if [[ $blacklist =~ $REPO ]]; then
        echo -e "\n$REPO is in blacklist, skipping"
    else
        case $REPO in
            device/qcom/sepolicy) repo_url="$CAF/$REPO" ;;
            build/make) repo_url="$CAF/platform/build" ;;
            vendor/codeaurora/commonsys/telephony)
                repo_url="$CAF/platform/vendor/codeaurora/telephony" ;;
            vendor/qcom/opensource/commonsys/bluetooth)
                repo_url="$CAF/platform/vendor/qcom-opensource/bluetooth" ;;
            vendor/qcom/opensource/commonsys/bluetooth_ext)
                repo_url="$CAF/platform/vendor/qcom-opensource/bluetooth_ext" ;;
            vendor/qcom/opensource/commonsys/fm)
                repo_url="$CAF/platform/vendor/qcom-opensource/fm-commonsys" ;;
            vendor/qcom/opensource/commonsys/system/bt)
                repo_url="$CAF/platform/vendor/qcom-opensource/system/bt" ;;
            vendor/qcom/opensource/commonsys-intf/display)
                repo_url="$CAF/platform/vendor/qcom-opensource/display-commonsys-intf" ;;
            vendor/qcom*) repo_url="$CAF/platform/$(echo $REPO | sed -e 's|qcom/opensource|qcom-opensource|')" ;;
            *) repo_url="$CAF/platform/$REPO" ;; esac

        if wget -q --spider $repo_url; then
            echo -e "$blu \nMerging $REPO $end"
            cd $REPO
            reset_branch
            git fetch -q $repo_url $TAG &> /dev/null
            if git merge FETCH_HEAD -q -m "Merge tag '$TAG' into $BRANCH" &> /dev/null; then
                if [[ $(git rev-parse HEAD) != $(git rev-parse wave/$BRANCH) ]] && [[ $(git diff HEAD wave/$BRANCH) ]]; then
                    echo "$REPO" >> $WAVE_PATH/success
                    echo "${grn}Merging $REPO succeeded :) $end"
                else
                    echo "$REPO - unchanged"
                    git reset --hard wave/$BRANCH &> /dev/null
                fi
            else
                echo "$REPO" >> $WAVE_PATH/failed
                echo "${red}$REPO merging failed :( $end"
            fi
        else echo $REPO >> ${WAVE_PATH}/notcaf; fi
        cd $WAVE_PATH
    fi
done

echo -e "$red \nThese repos failed merging: \n $end"
cat failed
echo -e "$grn \nThese repos succeeded merging: \n $end"
cat success

echo $red
read -p "Do you want to push the succesfully merged repos? (Y/N): " PUSH
echo $end

if [[ $PUSH == "Y" ]] || [[ $PUSH == "y" ]]; then
    # Push succesfully merged repos
    for REPO in $(cat success); do
        cd $REPO
        echo -e "\nPushing $REPO ..."
        git push -q wave HEAD:$BRANCH &> /dev/null
        cd $WAVE_PATH
    done

    # Auto-merge manifest too
    cd manifest
    echo -e "\nMerging and pushing manifest ..."
    reset_branch
    wget -q "https://source.codeaurora.org/quic/la/platform/manifest/plain/${TAG}.xml?h=$TAG" -O default.xml &> /dev/null
    sed -i '0,/default/s/default/default sync-j="6" sync-c="true"/' default.xml
    sed -i '$i \ \ <include name="remove.xml" />' default.xml
    sed -i '$i \ \ <include name="wave.xml" />' default.xml
    git commit -a -m "manifest: Merge tag '$TAG' into $BRANCH" &> /dev/null
    git push wave HEAD:$BRANCH &> /dev/null
    cd $WAVE_PATH

    # Update CAF version in vendor/wave
    cd vendor/wave
    echo -e "\nUpdating CAF version in vendor/wave and pushing ..."
    reset_branch
    sed -i "s|CAF_VERSION := .*|CAF_VERSION := $TAG|g" configs/branding.mk
    git commit -a -m "configs: Update CAF version to $TAG" &> /dev/null
    git push wave HEAD:$BRANCH &> /dev/null
    cd $WAVE_PATH
fi

echo -e "\n${blu}All done :) $end"
