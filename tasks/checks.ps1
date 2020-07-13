Get-Content c:\\datacenter.txt

cd $( puppet agent --configprint statedir )
cat .\resources.txt