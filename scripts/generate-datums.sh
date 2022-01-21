set -eu
thisDir=$(dirname "$0")
tempDir=$thisDir/../temp

nowSeconds=$(date +%s)
now=$(($nowSeconds*1000))
timestamp=$(($nowSeconds*1000+$1))
betterOfferTimestamp=$(($timestamp+5000000000))
prefix=${2:-0}

mkdir -p $tempDir/$BLOCKCHAIN_PREFIX/datums/$prefix
mkdir -p $tempDir/$BLOCKCHAIN_PREFIX/redeemers/$prefix

sellerPkh=$(cat $tempDir/$BLOCKCHAIN_PREFIX/pkhs/seller-pkh.txt)
marketplacePkh=$(cat $tempDir/$BLOCKCHAIN_PREFIX/pkhs/marketplace-pkh.txt)
royaltyPkh=$(cat $tempDir/$BLOCKCHAIN_PREFIX/pkhs/royalities-pkh.txt)
buyerPkh=$(cat $tempDir/$BLOCKCHAIN_PREFIX/pkhs/buyer-pkh.txt)

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/datums/$prefix/buy.json
{
  "constructor": 0,
  "fields": [
    {
      "constructor": 0,
      "fields": [
        {
          "int": 10000000
        },
        {
          "bytes": "$sellerPkh"
        },
        {
          "int": 25
        },
        {
          "bytes": "$royaltyPkh"
        },
        {
          "bytes": "d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2"
        },
        {
          "bytes": "123456"
        }
      ]
    }
  ]
}

EOF

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/datums/$prefix/buy2.json
{
  "constructor": 0,
  "fields": [
    {
      "constructor": 0,
      "fields": [
        {
          "int": 10000000
        },
        {
          "bytes": "$sellerPkh"
        },
        {
          "int": 25
        },
        {
          "bytes": "$royaltyPkh"
        },
        {
          "bytes": "380eab015ac8e52853df3ac291f0511b8a1b7d9ee77248917eaeef10"
        },
        {
          "bytes": "123456"
        }
      ]
    }
  ]
}

EOF

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/datums/$prefix/buy-high-royalty.json
{
  "constructor": 0,
  "fields": [
    {
      "constructor": 0,
      "fields": [
        {
          "int": 10000000
        },
        {
          "bytes": "$sellerPkh"
        },
        {
          "int": 200
        },
        {
          "bytes": "$royaltyPkh"
        },
        {
          "bytes": "d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2"
        },
        {
          "bytes": "123456"
        }
      ]
    }
  ]
}

EOF

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/datums/$prefix/buy-no-royalty.json
{
  "constructor": 0,
  "fields": [
    {
      "constructor": 0,
      "fields": [
        {
          "int": 10000000
        },
        {
          "bytes": "$sellerPkh"
        },
        {
          "int": 0
        },
        {
          "bytes": "$royaltyPkh"
        },
        {
          "bytes": "d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2"
        },
        {
          "bytes": "123456"
        }
      ]
    }
  ]
}

EOF

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/datums/$prefix/buy-seller-is-royalty.json
{
  "constructor": 0,
  "fields": [
    {
      "constructor": 0,
      "fields": [
        {
          "int": 10000000
        },
        {
          "bytes": "$sellerPkh"
        },
        {
          "int": 20
        },
        {
          "bytes": "$sellerPkh"
        },
        {
          "bytes": "d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2"
        },
        {
          "bytes": "123456"
        }
      ]
    }
  ]
}

EOF

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/datums/$prefix/buy-seller-is-marketplace.json
{
  "constructor": 0,
  "fields": [
    {
      "constructor": 0,
      "fields": [
        {
          "int": 10000000
        },
        {
          "bytes": "$marketplacePkh"
        },
        {
          "int": 20
        },
        {
          "bytes": "$sellerPkh"
        },
        {
          "bytes": "d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2"
        },
        {
          "bytes": "123456"
        }
      ]
    }
  ]
}

EOF

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/datums/$prefix/update.json
{
  "constructor": 0,
  "fields": [
    {
      "constructor": 0,
      "fields": [
        {
          "int": 11000000
        },
        {
          "bytes": "$sellerPkh"
        },
        {
          "int": 25
        },
        {
          "bytes": "$royaltyPkh"
        },
        {
          "bytes": "d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2"
        },
        {
          "bytes": "123456"
        }
      ]
    }
  ]
}

EOF

$thisDir/hash-datums.sh

updateDatumHash=$(cat $tempDir/$BLOCKCHAIN_PREFIX/datums/$prefix/update-hash.txt)

cat << EOF > $tempDir/$BLOCKCHAIN_PREFIX/redeemers/$prefix/update-redeemer.json
{
  "constructor": 0,
  "fields": [
    {
      "bytes" : "$updateDatumHash"
    }
  ]
}

EOF
