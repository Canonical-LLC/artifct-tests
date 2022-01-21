set -eux

thisDir=$(dirname "$0")

$thisDir/lock-cancel.sh
$thisDir/lock-swap.sh
$thisDir/lock-high-royalty-swap.sh
$thisDir/lock-update.sh
$thisDir/nft-goes-to-wrong-address.sh
$thisDir/too-little-ada.sh
$thisDir/too-little-fees.sh
$thisDir/too-little-royalties.sh
$thisDir/wrong-nft.sh
