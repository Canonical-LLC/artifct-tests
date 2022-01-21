set -eux

thisDir=$(dirname "$0")
baseDir=$thisDir/../
tempDir=$baseDir/../temp



bodyFile=$tempDir/cancel-tx-body.01
outFile=$tempDir/cancel-tx.01
walletAddr=$1
signingKey=$2
value=$3
datumFile=$4
datumHash=$5
sellerAddr=$6
redeemerFile=$7
newDatumHash=$8
newDatum=$9
sellerUtxo=${10}

utxoScript=$(scripts/query/sc.sh | grep $datumHash | grep "$value" | head -n 1 | cardano-cli-balance-fixer parse-as-utxo)
scriptHash=$(cat $baseDir/$BLOCKCHAIN_PREFIX/artifct-lbuc.addr)
nftValidatorFile=$baseDir/../../artifct-lbuc-sc/scripts/artifct-lbuc.plutus


cardano-cli transaction build \
    --alonzo-era \
    $BLOCKCHAIN \
    --tx-in $sellerUtxo \
    --tx-in $utxoScript \
    --tx-in-script-file $nftValidatorFile \
    --tx-in-datum-file $datumFile \
    --tx-in-redeemer-file $redeemerFile \
    --required-signer $signingKey \
    --tx-in-collateral $(cardano-cli-balance-fixer collateral --address $walletAddr $BLOCKCHAIN) \
    --tx-out "$scriptHash + $value" \
    --tx-out-datum-hash $newDatumHash \
    --change-address $walletAddr \
    --protocol-params-file scripts/$BLOCKCHAIN_PREFIX/protocol-parameters.json \
    --out-file $bodyFile

cardano-cli transaction sign \
   --tx-body-file $bodyFile \
   --signing-key-file $signingKey \
   $BLOCKCHAIN \
   --out-file $outFile

cardano-cli transaction submit \
  $BLOCKCHAIN \
  --tx-file $outFile
