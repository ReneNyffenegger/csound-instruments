for f in *
do
    mac2unix < $f > $f.new
    mv $f.new $f
done