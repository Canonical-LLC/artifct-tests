set -eu

thisDir=$(dirname "$0")
baseDir=$thisDir/../
tempDir=$baseDir/../temp

DATUM_PREFIX=${1:-0}

$baseDir/core/swap-buy-no-royalties-tx.sh \
  $(cat ~/$BLOCKCHAIN_PREFIX/buyer.addr) \
  $(cat ~/$BLOCKCHAIN_PREFIX/seller.addr) \
  $(cat ~/$BLOCKCHAIN_PREFIX/marketplace.addr) \
  ~/$BLOCKCHAIN_PREFIX/buyer.skey \
  "1724100 lovelace + 1 d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2.123456" \
  "8000000 lovelace" \
  "1000000 lovelace" \
  $tempDir/$BLOCKCHAIN_PREFIX/datums/$DATUM_PREFIX/buy-no-royalty.json \
  "$baseDir/shared-redeemers/buy-redeemer.json" \
  $(cat $tempDir/$BLOCKCHAIN_PREFIX/datums/$DATUM_PREFIX/buy-no-royalty-hash.txt) \
  $(cat ~/$BLOCKCHAIN_PREFIX/buyer.addr)
