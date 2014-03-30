#!/bin/bash

ROOT=$(cd $(dirname "$0"); pwd)
BINARYDIR=$(cd $(dirname "$0"); pwd)/build_output
DEPLOYDIR=$(cd $(dirname "$0"); pwd)/ReleaseBinaries
PACKAGEDIR=$(cd $(dirname "$0"); pwd)/Packages
LIB=$(cd $(dirname "$0"); pwd)/lib

if [ -d $BINARYDIR ]; then
{
    rm -r $BINARYDIR/
}
fi
if [ -d $DEPLOYDIR ]; then
{
    rm -r $DEPLOYDIR/
}
fi
if [ -d $PACKAGEDIR ]; then
{
    rm -r $PACKAGEDIR/
}
fi

mkdir $BINARYDIR
mkdir $DEPLOYDIR
mkdir $PACKAGEDIR
mkdir $DEPLOYDIR/EditorEngine
mkdir $DEPLOYDIR/CodeEngine
mkdir $DEPLOYDIR/EventListener
mkdir $DEPLOYDIR/tests
mkdir $DEPLOYDIR/Packaging

mkdir $DEPLOYDIR/.OpenIDE

mkdir $PACKAGEDIR/oipkg
mkdir $PACKAGEDIR/go-files
mkdir $PACKAGEDIR/go-files/rscripts
mkdir $PACKAGEDIR/go-files/graphics
mkdir $PACKAGEDIR/python-files
mkdir $PACKAGEDIR/python-files/rscripts
mkdir $PACKAGEDIR/python-files/graphics
mkdir $PACKAGEDIR/js-files
mkdir $PACKAGEDIR/js-files/lib
mkdir $PACKAGEDIR/php-files

mkdir $DEPLOYDIR/.OpenIDE/scripts
mkdir $DEPLOYDIR/.OpenIDE/scripts/templates

mkdir $DEPLOYDIR/.OpenIDE/rscripts
mkdir $DEPLOYDIR/.OpenIDE/rscripts/templates

mkdir $DEPLOYDIR/.OpenIDE/test
mkdir $DEPLOYDIR/.OpenIDE/test/templates

xbuild OpenIDE.sln /target:rebuild /property:OutDir=$BINARYDIR/ /p:Configuration=Release;
xbuild OpenIDE.CodeEngine.sln /target:rebuild /property:OutDir=$BINARYDIR/ /p:Configuration=Release;
xbuild PackageManager/oipckmngr/oipckmngr.csproj /target:rebuild /property:OutDir=$BINARYDIR/ /p:Configuration=Release;

# oi
cp $ROOT/oi/oi $DEPLOYDIR/oi
cp $ROOT/oi/oi.bat $DEPLOYDIR/oi.bat
cp $BINARYDIR/oi.exe $DEPLOYDIR/
cp $BINARYDIR/OpenIDE.dll $DEPLOYDIR/
cp $BINARYDIR/OpenIDE.Core.dll $DEPLOYDIR/
cp $BINARYDIR/Newtonsoft.Json.dll $DEPLOYDIR/

# Code model engine
cp $BINARYDIR/OpenIDE.CodeEngine.exe $DEPLOYDIR/CodeEngine/OpenIDE.CodeEngine.exe
cp $BINARYDIR/OpenIDE.CodeEngine.Core.dll $DEPLOYDIR/CodeEngine/OpenIDE.CodeEngine.Core.dll
cp $BINARYDIR/OpenIDE.Core.dll $DEPLOYDIR/CodeEngine/
cp $BINARYDIR/Newtonsoft.Json.dll $DEPLOYDIR/CodeEngine/
cp $ROOT/lib/FSWatcher/FSWatcher.dll $DEPLOYDIR/CodeEngine/

# Editor engine
cp -r $LIB/EditorEngine/* $DEPLOYDIR/EditorEngine

# Event listener
cp $BINARYDIR/OpenIDE.EventListener.exe $DEPLOYDIR/EventListener/

# Tests
cp -r $ROOT/oi/tests/* $DEPLOYDIR/tests

# Reactive scripts
cp -r $ROOT/oi/rscripts/* $DEPLOYDIR/.OpenIDE/rscripts

# Package manager
cp $BINARYDIR/oipckmngr.exe $DEPLOYDIR/Packaging
cp $BINARYDIR/OpenIDE.Core.dll $DEPLOYDIR/Packaging
cp $BINARYDIR/Newtonsoft.Json.dll $DEPLOYDIR/Packaging
cp $BINARYDIR/ICSharpCode.SharpZipLib.dll $DEPLOYDIR/Packaging

# Templates
cp -r $ROOT/oi/script-templates/* $DEPLOYDIR/.OpenIDE/scripts/templates
cp -r $ROOT/oi/rscript-templates/* $DEPLOYDIR/.OpenIDE/rscripts/templates
cp -r $ROOT/oi/test-templates/* $DEPLOYDIR/.OpenIDE/test/templates

# Packages

# go
cp $ROOT/Languages/go/bin/go $PACKAGEDIR/go
cp $ROOT/Languages/go/package.json $PACKAGEDIR/go-files/package.json
cp $ROOT/Languages/go/rscripts/go-build.sh $PACKAGEDIR/go-files/rscripts/go-build.sh
cp $ROOT/Languages/go/graphics/* $PACKAGEDIR/go-files/graphics/

# python
cp -r $ROOT/Languages/python/* $PACKAGEDIR

# Javascript
cp $ROOT/Languages/js/js.js $PACKAGEDIR/js
cp -r $ROOT/Languages/js/js-files/* $PACKAGEDIR/js-files

# Php
cp -r $ROOT/Languages/php/* $PACKAGEDIR

# Building packages
echo "Building packages.."
$DEPLOYDIR/oi package build Packages/go $PACKAGEDIR/oipkg
$DEPLOYDIR/oi package build Packages/python $PACKAGEDIR/oipkg
$DEPLOYDIR/oi package build Packages/js $PACKAGEDIR/oipkg
$DEPLOYDIR/oi package build Packages/php $PACKAGEDIR/oipkg
rm $DEPLOYDIR/.OpenIDE/oi-definitions.json
rm $DEPLOYDIR/oi-definitions.json
