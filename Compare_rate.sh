#!/bin/ksh

#Need to dynamically read value of price difference from Form

#Below is just of testing
Output_File=/home/user/Output.out

Date_Time=`date +"%Y-%m-%d %H:%M:%S"`

Diff_value="0.1"

wget -o COIN_BASE_DOWNLOAD.log https://coinbase.com/api/v1/prices/spot_rate

COIN_BASE="spot_rate"

COIN_BASE_VALUE=`cat spot_rate | cut -d":" -f2 | cut -d"," -f1 | tr -d "\""`

echo "*******Comparison of COIN BASE and BIT STAMP Prices @ $Date_Time ******" >> $Output_File


echo "COIN BASE VALUE = $COIN_BASE_VALUE" >> $Output_File


wget -o bitstamp_download.log https://www.bitstamp.net/api/ticker/

BITSTAMP_VALUE=`cat index.html  | cut -d":" -f3 | cut -d"," -f1 | tr -d "\"" | tr -d " "`

echo "BITSTAMP VALUE= $BITSTAMP_VALUE" >>$Output_File


#CoinminBit=`expr $COIN_BASE_VALUE - $BITSTAMP_VALUE`
#BitminCoin=`expr $BITSTAMP_VALUE - $COIN_BASE_VALUE`
CoinminBit=`echo "$COIN_BASE_VALUE-$BITSTAMP_VALUE" | bc`
BitminCoin=`echo "$BITSTAMP_VALUE-$COIN_BASE_VALUE" | bc`


#echo "$CoinminBit $BitminCoin"


if [ $CoinminBit -gt $Diff_value ];
then

echo "COIN BASE is greater than BITSTAMP. Difference= $CoinminBit" >>$Output_File

echo "Coin Base is greater than Bitstamp = $CoinminBit" | mailx -s "COIN_BASE_VALUE-BITSTAMP_VALUE is $CoinminBit" subodh@nyu.edu


fi


if [ $BitminCoin -gt $Diff_value ];
then

echo "BITSTAMP is grater than COINBASE. Difference= $BitminCoin" >>$Output_File

echo "Bitstamp is grater than coin base $BitminCoin" | mailx -s "BITSTAMP_VALUE-COIN_BASE_VALUE is $BitminCoin" subodh@nyu.edu

fi

/bin/cat $Output_File




rm spot_rate index.html *log
