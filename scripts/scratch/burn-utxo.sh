set -eux

bodyFile=temp/consolidate-tx-body.01
signingKey=~/$BLOCKCHAIN_PREFIX/buyer.skey
outFile=temp/consolidate-tx.01
buyerAddr=$(cat ~/$BLOCKCHAIN_PREFIX/buyer.addr)
burnAddr=$(cat ~/$BLOCKCHAIN_PREFIX/burn.addr)

cardano-cli transaction build \
  --alonzo-era \
  $BLOCKCHAIN \
  --tx-in 757a0ca5c8e3a269def5f8061a8fbba4a3554042a31dc3a50d42863f1127e4a2#2 \
  --tx-out "$burnAddr + 1800000 lovelace + 1 380eab015ac8e52853df3ac291f0511b8a1b7d9ee77248917eaeef10.123456 + 8 d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2.123456" \
  --change-address $burnAddr \
  --protocol-params-file scripts/$BLOCKCHAIN_PREFIX/protocol-parameters.json \
  --out-file $bodyFile

echo "saved transaction to $bodyFile"

cardano-cli transaction sign \
   --tx-body-file $bodyFile \
   --signing-key-file $signingKey \
   $BLOCKCHAIN \
   --out-file $outFile

echo "signed transaction and saved as $outFile"

cardano-cli transaction submit \
 $BLOCKCHAIN \
 --tx-file $outFile

echo "submitted transaction"
