#/bin/bash
WORKSPACE=/Users/mschrag/Documents/wolips
ECLIPSE=/Developer/Applications/Eclipse/eclipse36RC3Cocoa
TEMPDIR=/tmp/veogenjar
MANIFEST=/tmp/MANIFEST.MF
OUTPUT=/tmp/veogen-`svn info | grep Revision | sed 's#.* ##g'`.jar

echo Veogen
mkdir -p $TEMPDIR
cd $TEMPDIR

echo Copying classes ...
cp -r $WORKSPACE/woproject/wolips/core/plugins/org.objectstyle.wolips.eogenerator.core/bin/* .
cp -r $WORKSPACE/woproject/wolips/core/plugins/org.objectstyle.wolips.eogenerator.core/templates .
rm -rf $TEMPDIR/templates/.svn
cp -r $WORKSPACE/woproject/wolips/core/plugins/org.objectstyle.wolips.eomodeler.core/bin/* .
cp -r $WORKSPACE/woproject/wolips/core/plugins/org.objectstyle.wolips.eomodeler.eclipse/bin/* .
cp -r $WORKSPACE/woproject/wolips/core/plugins/org.objectstyle.wolips.baseforplugins/bin/* .
cp -r $WORKSPACE/woproject/wolips/veogen/bin/* .
cp -r $WORKSPACE/woproject/wolips/core/plugins/org.objectstyle.wolips.eomodeler.doc/bin/* .
cp -r $WORKSPACE/woproject/wolips/core/plugins/org.objectstyle.wolips.eomodeler.factories/bin/* .
cp -r $WORKSPACE/woproject/wolips/core/plugins/org.objectstyle.wolips.thirdparty.velocity/bin/* .

echo Unjarring plugins ...
jar xvf $ECLIPSE/plugins/org.eclipse.equinox.common_*.jar > /dev/null
jar xvf $ECLIPSE/plugins/org.eclipse.core.runtime_*.jar > /dev/null
jar xvf $ECLIPSE/plugins/org.eclipse.core.resources_*.jar > /dev/null
jar xvf $ECLIPSE/plugins/org.eclipse.core.jobs_*.jar > /dev/null
jar xvf $ECLIPSE/plugins/org.eclipse.osgi_*.jar > /dev/null
jar xvf $WORKSPACE/woproject/wolips/core/plugins/org.objectstyle.wolips.woproject/lib/woproject.jar > /dev/null
jar xvf $WORKSPACE/woproject/wolips/core/plugins/org.objectstyle.wolips.thirdparty.velocity/lib/velocity-1.5.jar > /dev/null
jar xvf $WORKSPACE/woproject/wolips/core/plugins/org.objectstyle.wolips.thirdparty.velocity/lib/velocity-tools-generic-1.4.jar > /dev/null
jar xvf $WORKSPACE/woproject/wolips/core/plugins/org.objectstyle.wolips.thirdparty.velocity/lib/commons-lang-2.1.jar > /dev/null
jar xvf $WORKSPACE/woproject/wolips/core/plugins/org.objectstyle.wolips.thirdparty.commonscollections/lib/commons-collections-3.1.jar > /dev/null

rm -rf META-INF
if [ -e $MANIFEST ]; then
rm $MANIFEST
fi
if [ -e $OUTPUT ]; then
rm $OUTPUT
fi

echo Creating manifest ...
echo Manifest-Version: 1.0 >> $MANIFEST
echo Main-Class: veogen.Veogen >> $MANIFEST

echo Creating $OUTPUT ...
jar cvfm $OUTPUT $MANIFEST * > /dev/null
rm $MANIFEST
