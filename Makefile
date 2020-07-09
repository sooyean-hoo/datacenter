all:
	pwd ;
	find ./  -iname  manifests -type d | while read  line ;  do \
		 pushd $$PWD ;  cd $$line/.. ;  echo "===========In $$(pwd)=======" ;\
		 /opt/puppetlabs/pdk/bin/pdk validate ; popd ; \
		 echo "===============================" ;\
	done;
	find ./  -iname '*.pp' -exec /usr/local/bin/puppet parser validate   {}    \;    2>&1    |    sed -E 's/^[^\(]+\(file: //g' | \
	 sed  -E 's/^.+control-repo\///g'   1>&2  
 
autocorrect::
	pwd ;
	find ./  -iname  manifests -type d | while read  line ;  do \
		 pushd $$PWD ;  cd $$line/.. ;  echo "===========In $$(pwd)=======" ;\
		 /opt/puppetlabs/pdk/bin/pdk validate -a  ; popd ; \
		 echo "===============================" ;\
	done;
	find ./  -iname '*.pp' -exec /usr/local/bin/puppet parser validate   {}    \;    2>&1    |    sed -E 's/^[^\(]+\(file: //g' | \
	 sed  -E 's/^.+control-repo\///g'   1>&2  

checkFacts::
	 facter    -d --custom-dir   


 puppetClass_datacenter::
	 puppet apply --debug --modulepath=./site  -e "include   profile::datacenter "
	 
 puppetClass_example::
	 puppet apply --debug --modulepath=./site  -e "include   profile::example "


puppetClass_print::
	 puppet config print classfile


puppetClass_printall::
	 puppet config print all	 

find_pp::
	find ./ -name '*.pp' -exec awk '/^class [a-zA-Z]/ {print $2}' {} \;

puppetfind_pp::
	puppet doc --outputdir /tmp/puppetdoc --mode rdoc  --modulepath ./       

showtask::
	bolt task show  -module-dir=./