set -eu

thisDir=$(dirname "$0")
baseDir=$thisDir/..

$baseDir/minting/mint-0-policy.sh buyer
$baseDir/wait/until-next-block.sh
$baseDir/problem-cases/lock-no-nft-tx.sh
$baseDir/wait/until-next-block.sh

detected=false

"$baseDir/problem-cases/swap-already-has-nft-tx.sh" || {
    detected=true
}

if [ $detected == false ]; then
  echo "failed!"
  $baseDir/wait/until-next-block.sh
  $baseDir/scratch/buyer-to-seller-utxo.sh
  $baseDir/wait/until-next-block.sh
  exit 1
fi
