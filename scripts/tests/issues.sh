set -eux

thisDir=$(dirname "$0")

$thisDir/missing-royalty.sh
$thisDir/missing-fee.sh
