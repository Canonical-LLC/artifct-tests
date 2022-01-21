set -eux

baseDir="scripts"

bodyFile=temp/swap-tx-body.01
outFile=temp/swap-tx.01
buyerAddr=$1
sellerAddr=$2
signingKey=$3
value=$4
sellerAmount=$5
datumFile="${6}"
royalitiesAddr="${7}"
royalitiesAmount="${8}"
redeemerFile="${9}"
datumHash="${10}"
spenderAddress="${11}"
nftValidatorFile=$baseDir/../../artifct-lbuc-sc/scripts/artifct-lbuc.plutus
scriptHash=$(cat scripts/$BLOCKCHAIN_PREFIX/artifct-lbuc.addr)

utxoScript=$(scripts/query/sc.sh | grep $datumHash | head -n 1 | cardano-cli-balance-fixer parse-as-utxo)
changeOutput=$(cardano-cli-balance-fixer change --address $spenderAddress $BLOCKCHAIN)

extraOutput=""
if [ "$changeOutput" != "" ];then
  extraOutput="+ $changeOutput"
fi

cardano-cli transaction build \
    --alonzo-era \
    $BLOCKCHAIN \
    $(cardano-cli-balance-fixer input --address $spenderAddress $BLOCKCHAIN ) \
    --tx-in $utxoScript \
    --tx-in-script-file $nftValidatorFile \
    --tx-in-datum-file $datumFile \
    --tx-in-redeemer-file $redeemerFile \
    --required-signer $signingKey \
    --tx-in-collateral $(cardano-cli-balance-fixer collateral --address $spenderAddress $BLOCKCHAIN ) \
    --tx-out "$sellerAddr + $sellerAmount" \
    --tx-out "$buyerAddr + $value" \
    --tx-out "$royalitiesAddr + $royalitiesAmount" \
    --tx-out "$spenderAddress + 3000000 lovelace $extraOutput" \
    --change-address $spenderAddress \
    --protocol-params-file $baseDir/$BLOCKCHAIN_PREFIX/protocol-parameters.json \
    --out-file $bodyFile

cardano-cli transaction sign \
   --tx-body-file $bodyFile \
   --signing-key-file $signingKey \
   $BLOCKCHAIN \
   --out-file $outFile

cardano-cli transaction submit \
  $BLOCKCHAIN \
  --tx-file $outFile
