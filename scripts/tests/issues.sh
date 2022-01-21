set -eux

thisDir=$(dirname "$0")

$thisDir/zero-royalty-price-is-too-low.sh
$thisDir/missing-nft.sh
$thisDir/double-swap-with-same-datum-hash.sh
$thisDir/missing-royalty.sh
$thisDir/missing-fee.sh
