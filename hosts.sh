#hosts更新

changehosts( )
{
    mount -o rw,remount /system
    chmod 777 "$AIM"
    cat "$DIR"/hosts.tmp > "$AIM"
    cat "$DIR"/adhosts >> "$AIM"
    chmod 644 "$AIM"
}
DIR="/data/media/home"
#racaljk/hosts的翻墙hosts的源
SOURCE="https://coding.net/u/scaffrey/p/hosts/git/raw/master/hosts"
AIM="/system/etc/hosts"
#vokins/yhosts的拦截广告的源
ADSOURCE="https://raw.githubusercontent.com/vokins/yhosts/master/hosts"
#把脚本写入/data/media，这样刷机后脚本也不会不见
if [ -f "$DIR"/hosts.sh ] ;then
     echo 'shell is in /data/media/home'
else
     mkdir "$DIR"
     cd `dirname $0`
     cp hosts.sh "$DIR"
     chmod -R 777 "$DIR" 
fi

echo 'downloading hosts'
if [ -e "$DIR"/adhosts ] ; then
      echo 'advertisement hosts existed'
else 
      echo 'downloading adhosts'
      curl -ks "$ADSOURCE" -o "$DIR"/adhosts
fi
curl -ks "$SOURCE" -o "$DIR"/hosts.tmp
echo 'finished downloading'
echo ' '
echo ' old version:  '
head -n3 "$AIM"
echo '####################'
echo ' new version:  '
head -n3 "$DIR"/hosts.tmp
echo '####################'
echo 'backup old version'
cat "$AIM" > "$DIR"/oldhosts
if [ -e "$DIR"/hosts.tmp ] ; then
     changehosts
fi
echo ok
