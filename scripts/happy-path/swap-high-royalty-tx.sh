set -eux

DATUM_PREFIX=${1:-0}

thisDir=$(dirname "$0")
baseDir=$thisDir/../
tempDir=$baseDir/../temp

$baseDir/core/swap-buy-tx.sh \
  $(cat ~/$BLOCKCHAIN_PREFIX/buyer.addr) \
  $(cat ~/$BLOCKCHAIN_PREFIX/seller.addr) \
  $(cat ~/$BLOCKCHAIN_PREFIX/marketplace.addr) \
  ~/$BLOCKCHAIN_PREFIX/buyer.skey \
  "1724100 lovelace + 1 d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2.123456" \
  "7000000 lovelace" \
  "1000000 lovelace" \
  $tempDir/$BLOCKCHAIN_PREFIX/datums/$DATUM_PREFIX/buy-high-royalty.json \
  $(cat ~/$BLOCKCHAIN_PREFIX/royalities.addr) \
  "2000000 lovelace" \
  "$baseDir/shared-redeemers/buy-redeemer.json" \
  $(cat $tempDir/$BLOCKCHAIN_PREFIX/datums/$DATUM_PREFIX/buy-high-royalty-hash.txt) \
  $(cat ~/$BLOCKCHAIN_PREFIX/buyer.addr)