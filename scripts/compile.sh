set -eu
thisDir=$(dirname "$0")
tempDir=$thisDir/../temp
artifctDir=$thisDir/../../artifct-lbuc-sc

(
cd $artifctDir
cabal run tp-nami-script -- $(cat ../artifct-tests/$tempDir/$BLOCKCHAIN_PREFIX/pkhs/marketplace-pkh.txt)
)

$thisDir/hash-plutus.sh
