set -eux

thisDir=$(dirname "$0")

$thisDir/missing-royalty.sh
$thisDir/lock-cancel.sh
$thisDir/lock-swap.sh
$thisDir/lock-high-royalty-swap.sh
$thisDir/nft-goes-to-wrong-address.sh
$thisDir/too-little-ada.sh
$thisDir/too-little-fees.sh
$thisDir/too-little-royalties.sh
$thisDir/wrong-nft.sh
$thisDir/zero-royalty-price-is-too-low.sh
$thisDir/missing-nft.sh
$thisDir/double-swap-with-same-datum-hash.sh
