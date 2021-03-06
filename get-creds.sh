while read -r line
do
    if [[ $line =~ "data: " ]]; then
        DATA=${line:6}
    fi
    if [[ $line =~ "name: " ]]; then
        NAME=${line:6}
    fi
done < <($VOLTERRA_CLI_PATH/vesctl request rpc api_credential.CustomAPI.Create -i $TEMPLATE --uri /public/namespaces/system/api_credentials --http-method POST --timeout 10 | sed 's/%0A/\n/g')

mkdir -p ~/.kube/

base64 --decode <<< $DATA > $HOME/.kube/config
echo "KUBECONFIG=$HOME/.kube/config" >> $GITHUB_ENV
echo $NAME